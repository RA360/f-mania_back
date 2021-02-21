<?php
// Headers
header('Access-Control-Allow-Origin: http://localhost:3000');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: *');
// Origin, Content-Type, Authorization
header('Content-Type: application/json');
// Connect to db
$connect = mysqli_connect('localhost', 'root', 'root', 'f-mania');
// If disconnect die
!$connect && die();
// Split url into array
$params = explode('/', $_GET['url']);
// JWT class
class JWT
{
  private static $alg = 'sha256';

  private static function base64Encode($data)
  {
    return str_replace('=', '', strtr(base64_encode($data), '+/', '-_'));
  }

  public static function encode($payload, $exp = 900, $secret = 'LR^FDhFr+hdFvRJ88VP@#w5LKyBWsjQE')
  {
    // Add expire time
    $payload['exp'] = time() + $exp;
    // Encode header + payload and join with dot
    $str = static::base64Encode(json_encode([
      'alg' => static::$alg,
      'typ' => 'JWT',
    ])) . '.' . static::base64Encode(json_encode($payload));
    // Finally return token
    return "$str." . static::base64Encode(hash_hmac(
      static::$alg,
      $str,
      static::base64Encode($secret),
      true
    ));
  }

  public static function decode($secret = 'LR^FDhFr+hdFvRJ88VP@#w5LKyBWsjQE')
  {
    $authHeader = getallheaders()['Authorization'];
    // Check if exist Auth barear JWT
    if ($authHeader) {
      $JWTParts = explode('.', trim(substr($authHeader, 7)));
      // If valid JWT decode it
      if (count($JWTParts) == 3 && hash_equals(static::base64Encode(hash_hmac(
        static::$alg,
        "$JWTParts[0].$JWTParts[1]",
        static::base64Encode($secret),
        true
      )), $JWTParts[2])) {
        $remainder = strlen($JWTParts[1]) % 4;
        $remainder && $JWTParts[1] .= str_repeat('=', 4 - $remainder);
        $payload = json_decode(base64_decode(strtr($JWTParts[1], '-_', '+/')), true);
        if ($payload['exp'] > time())
          return $payload;
      }
    }
    http_response_code(401);
    return false;
  }
}
// For input test
function testInput($data)
{
  return htmlspecialchars(stripslashes(trim($data)));
}
// If version v1
if ($params[0] == 'v1') {
  switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
      switch ($params[1]) {
        case 'account':
          $info = JWT::decode();
          // If JWT is valid echo user info
          if ($info) {
            http_response_code(200);
            echo json_encode($info);
          }
          break;
        case 'filters':
          http_response_code(200);
          echo json_encode([
            'categories' => mysqli_fetch_all(mysqli_query($connect, 'SELECT * FROM categories'), MYSQLI_ASSOC),
            'colors' => mysqli_fetch_all(mysqli_query($connect, 'SELECT * FROM colors'), MYSQLI_ASSOC),
            'sizes' => mysqli_fetch_all(mysqli_query($connect, 'SELECT * FROM sizes'), MYSQLI_ASSOC)
          ]);
          break;
        case 'products':
          if (+$params[2]) {
            if (isset($params[3])) {
              if ($params[3] == 'reviews') {
                $reviews = mysqli_query($connect, "SELECT u.firstName, u.lastName, r.text, r.rating, r.date FROM reviews r JOIN users u ON u.id = r.user_id AND r.product_id = $params[2]");
                // If exist reviews
                if (mysqli_num_rows($reviews)) {
                  http_response_code(200);
                  echo json_encode(mysqli_fetch_all($reviews, MYSQLI_ASSOC));
                } else http_response_code(404);
              }
            } else {
              $products = mysqli_query(
                $connect,
                "SELECT p.*, o.quantity, c.id AS color_id, c.color, s.id AS size_id, s.size FROM offers o JOIN products p ON o.product_id = $params[2] AND p.id = o.product_id JOIN colors c ON c.id = o.color_id JOIN sizes s ON s.id = o.size_id"
              );
              // If exist products
              if (mysqli_num_rows($products)) {
                http_response_code(200);
                echo json_encode([
                  'products' => mysqli_fetch_all($products, MYSQLI_ASSOC),
                  'images' => mysqli_fetch_all(
                    mysqli_query(
                      $connect,
                      "SELECT i.img, t.thumb FROM images i JOIN thumbs t ON t.img_id = i.id AND i.product_id = $params[2]"
                    ),
                    MYSQLI_ASSOC
                  )
                ]);
              } else http_response_code(404);
            }
          } else {
            $data = [];
            $query = 'FROM offers o JOIN products p ON p.id = o.product_id';
            $sort = '';
            $start = '';
            $limit = +$_GET['limit'] > 100 ? 100 : $_GET['limit'];
            // Filter check
            isset($_GET['catsId']) && preg_match('/^\d+(,\d+)*$/', $_GET['catsId']) && $query .= " AND p.category_id IN ({$_GET['catsId']})";
            isset($_GET['colorsId']) && preg_match('/^\d+(,\d+)*$/', $_GET['colorsId']) && $query .= " AND o.color_id IN ({$_GET['colorsId']})";
            isset($_GET['sizesId']) && preg_match('/^\d+(,\d+)*$/', $_GET['sizesId']) && $query .= " AND o.size_id IN ({$_GET['sizesId']})";
            isset($_GET['page']) ?  $start =  $limit * +$_GET['page'] - $limit . ',' :
              $data['count'] = mysqli_fetch_assoc(mysqli_query($connect, "SELECT COUNT(DISTINCT p.id) AS count $query"))['count'];
            if (isset($_GET['sort'])) {
              if ($_GET['sort'] == 'new') $sort = 'ORDER BY p.id DESC';
              elseif ($_GET['sort'] == 'priceHigh') $sort = 'ORDER BY p.price DESC';
              elseif ($_GET['sort'] == 'priceLow') $sort = 'ORDER BY p.price ASC';
              elseif ($_GET['sort'] == 'rating') $sort = 'ORDER BY p.rating DESC';
            }
            // Get products
            $products = mysqli_query(
              $connect,
              "SELECT p.id, p.title, p.price, i.img $query JOIN images i ON i.product_id = p.id GROUP BY p.id $sort LIMIT $start $limit"
            );
            // Check if exist products
            if (mysqli_num_rows($products)) {
              $data['products'] = mysqli_fetch_all($products, MYSQLI_ASSOC);
              http_response_code(200);
              echo json_encode($data);
            } else http_response_code(404);
          }
          break;
        case 'cart':
          $info = JWT::decode();
          // If JWT is valid
          if ($info) {
            $products = mysqli_query(
              $connect,
              "SELECT cart.id, cart.product_id, cart.quantity, p.title, p.price, i.img, c.color, s.size, o.quantity AS maxQuantity FROM cart JOIN products p ON p.id = cart.product_id AND cart.user_id = {$info['id']} JOIN images i ON i.product_id = p.id JOIN colors c ON c.id = cart.color_id JOIN sizes s ON s.id = cart.size_id JOIN offers o ON o.product_id = p.id AND o.color_id = c.id AND o.size_id = s.id"
            );
            // If products exist
            if (mysqli_num_rows($products)) {
              http_response_code(200);
              echo json_encode(mysqli_fetch_all($products, MYSQLI_ASSOC));
            } else http_response_code(404);
          }
          break;
        case 'orders':
          $info = JWT::decode();
          // If JWT is valid
          if ($info) {
            $data = [];
            $start = '';
            $limit = +$_GET['limit'] > 100 ? 100 : $_GET['limit'];
            // If isset page order products by it or get products count
            isset($_GET['page']) ?  $start =  $limit * +$_GET['page'] - $limit . ',' :
              $data['count'] = mysqli_fetch_assoc(mysqli_query($connect, "SELECT COUNT(id) AS count FROM orders WHERE user_id = {$info['id']}"))['count'];
            // Get products
            $products = mysqli_query(
              $connect,
              "SELECT p.id, p.title, p.price, i.img, c.color, s.size, o.date FROM orders o JOIN products p ON p.id = o.product_id AND o.user_id = {$info['id']} JOIN images i ON i.product_id = p.id JOIN colors c ON c.id = o.color_id JOIN sizes s ON s.id = o.size_id LIMIT $start $limit"
            );
            // If products exist
            if (mysqli_num_rows($products)) {
              $data['products'] = mysqli_fetch_all($products, MYSQLI_ASSOC);
              http_response_code(200);
              echo json_encode($data);
            } else http_response_code(404);
          }
          break;
        case 'wishlist':
          $info = JWT::decode();
          // If JWT is valid
          if ($info) {
            $data = [];
            $start = '';
            $limit = +$_GET['limit'] > 100 ? 100 : $_GET['limit'];
            // If isset page order products by it or get products count
            isset($_GET['page']) ?  $start =  $limit * +$_GET['page'] - $limit . ',' :
              $data['count'] = mysqli_fetch_assoc(mysqli_query($connect, "SELECT COUNT(id) AS count FROM wishlist WHERE user_id = {$info['id']}"))['count'];
            // Get products
            $products = mysqli_query(
              $connect,
              "SELECT p.id, p.title, p.price, i.img FROM wishlist w JOIN products p ON p.id = w.product_id AND w.user_id = {$info['id']} JOIN images i ON i.product_id = p.id LIMIT $start $limit"
            );
            // If products exist
            if (mysqli_num_rows($products)) {
              $data['products'] = mysqli_fetch_all($products, MYSQLI_ASSOC);
              http_response_code(200);
              echo json_encode($data);
            } else http_response_code(404);
          }
          break;
        case 'search':
          $data = [];
          $query = testInput($_GET['q']);
          $start = '';
          $limit = +$_GET['limit'] > 100 ? 100 : $_GET['limit'];
          // If isset page order products by it or get products count
          isset($_GET['page']) ?  $start =  $limit * +$_GET['page'] - $limit . ',' :
            $data['count'] = mysqli_fetch_assoc(mysqli_query($connect, "SELECT COUNT(id) AS count FROM products WHERE title LIKE '$query%'"))['count'];
          // Get products
          $products = mysqli_query($connect, "SELECT p.id, p.title, p.price, i.img FROM products p JOIN images i WHERE p.title LIKE '$query%' AND i.product_id = p.id LIMIT $start $limit");
          // If products exist
          if (mysqli_num_rows($products)) {
            http_response_code(200);
            $data['products'] = mysqli_fetch_all($products, MYSQLI_ASSOC);
            echo json_encode($data);
          } else http_response_code(404);
      }
      break;
    case 'POST':
      switch ($params[1]) {
        case 'account':
          switch ($params[2]) {
            case 'login':
              $email = testInput($_POST['email']);
              $user = mysqli_fetch_assoc(mysqli_query($connect, "SELECT * FROM users WHERE email = '$email'"));
              if (password_verify($_POST['password'], $user['password'])) {
                unset($user['password']);
                http_response_code(200);
                echo json_encode([
                  'fullName' => "{$user['firstName']} {$user['lastName']}",
                  'JWT' => JWT::encode($user)
                ]);
              } else {
                http_response_code(400);
                echo 'Incorrect email or password';
              }
              break;
            case 'recover':
              $email = testInput($_POST['email']);
              $user = mysqli_query($connect, "SELECT id, password FROM users WHERE email = '$email'");
              if (mysqli_num_rows($user)) {
                $user = mysqli_fetch_assoc($user);
                $JWT = JWT::encode([], 86400, $user['id'] . $user['password']);
                mail(
                  $email,
                  'Reset yout password',
                  "Follow this link to reset yout account password at F-mania. If you didn't request a new password, you can safely delete this email.\r\nhttp://localhost:3000/account/reset/{$user['id']}/$JWT",
                  'From: support@f-mania.com'
                );
                http_response_code(200);
                echo 'We have sent you an email with instructions to reset your password';
              } else {
                http_response_code(400);
                echo 'No account found with that email';
              }
              break;
            case 'reset':
              $error = '';
              $id = +$_POST['id'];
              $user = mysqli_query($connect, "SELECT * FROM users WHERE id = $id");
              // If exist user else show error
              if (mysqli_num_rows($user)) {
                $user = mysqli_fetch_assoc($user);
                $JWT = JWT::decode($user['id'] . $user['password']);
                // If JWT is valid
                if ($JWT) {
                  // Password validation
                  if (!$_POST['password'])
                    $error = "Password can't be blank";
                  elseif (preg_match('/\s/', $_POST['password']))
                    $error = "Password can't contain a space";
                  elseif (strlen($_POST['password']) < 5)
                    $error = 'Password is too short (minimum is 5 characters)';
                  elseif ($_POST['password'] != $_POST['confirmPassword'])
                    $error = "Passwords don't match";
                  else {
                    // Encrypt password
                    $hash = password_hash($_POST['password'], PASSWORD_ARGON2I);
                    // Update user password
                    mysqli_query($connect, "UPDATE users SET password = '$hash' WHERE id = $id");
                    unset($user['password']);
                    echo json_encode([
                      'fullName' => "{$user['firstName']} {$user['lastName']}",
                      'JWT' => JWT::encode($user)
                    ]);
                    return http_response_code(200);
                  }
                } else $error = 'Password reset error';
              } else $error = 'Password reset error';
              // If error exist will show it
              http_response_code(400);
              echo json_encode($error);
              break;
            case 'register':
              $data = [];
              $firstName = testInput($_POST['firstName']);
              $lastName = testInput($_POST['lastName']);
              $email = testInput($_POST['email']);
              // First name validation
              !preg_match('/^[a-z]+$/i', $firstName) &&
                $data['errors'][] = 'Only letters allowed in First Name';
              // Last name validation
              !preg_match('/^[a-z]+$/i', $lastName) &&
                $data['errors'][] = 'Only letters allowed in Last Name';
              // Email validation
              if (!filter_var($email, FILTER_VALIDATE_EMAIL))
                $data['errors'][] = 'Invalid email format';
              elseif (mysqli_num_rows(mysqli_query($connect, "SELECT id FROM users WHERE email = '$email'")))
                $data['errors'][] = 'This email address is already associated with an account';
              // Password validation
              if (!$_POST['password'])
                $data['errors'][] = "Password can't be blank";
              elseif (preg_match('/\s/', $_POST['password']))
                $data['errors'][] = "Password can't contain a space";
              elseif (strlen($_POST['password']) < 5)
                $data['errors'][] = 'Password is too short (minimum is 5 characters)';
              elseif ($_POST['password'] != $_POST['confirmPassword'])
                $data['errors'][] = "Passwords don't match";
              // If errors not exist register user else show errors
              if (isset($data['errors'])) http_response_code(400);
              else {
                // Encrypt password
                $hash = password_hash($_POST['password'], PASSWORD_ARGON2I);
                // Insert user into db
                mysqli_query($connect, "INSERT INTO users (firstName, lastName, email, password) VALUES ('$firstName', '$lastName', '$email', '$hash')");
                // Write user info
                $data['fullName'] = "$firstName $lastName";
                $data['JWT'] = JWT::encode([
                  'id' => mysqli_insert_id($connect),
                  'firstName' => $firstName,
                  'lastName' => $lastName,
                  'email' => $email,
                  'phone' => ''
                ]);
              }
              echo json_encode($data);
          }
          break;
        case 'cart':
          $info = JWT::decode();
          // If JWT is valid
          if ($info) {
            $input = json_decode(file_get_contents('php://input'), true);
            $productId = +$input['productId'];
            $colorId = +$input['colorId'];
            $sizeId = +$input['sizeId'];
            $quantity = +$input['quantity'];
            $maxQuantity = mysqli_fetch_assoc(mysqli_query($connect, "SELECT quantity FROM offers WHERE product_id = $productId AND color_id = $colorId AND size_id = $sizeId"))['quantity'];
            // Validate quantity
            if ($quantity < 1) $quantity = 1;
            elseif ($quantity > $maxQuantity) $quantity = $maxQuantity;
            // if exist update quantity or insert product
            mysqli_query($connect, "INSERT INTO cart (user_id, product_id, color_id, size_id, quantity) VALUES ({$info['id']}, $productId, $colorId, $sizeId, $quantity) ON DUPLICATE KEY UPDATE quantity = $quantity");
            http_response_code(201);
            echo 'Product added to cart';
          }
          break;
        case 'wishlist':
          $info = JWT::decode();
          // If JWT is valid
          if ($info) {
            $id = +file_get_contents('php://input');
            // If exist product with this id
            if (mysqli_num_rows(mysqli_query($connect, "SELECT id FROM products WHERE id = $id"))) {
              // Insert product to wishlist
              mysqli_query($connect, "INSERT IGNORE INTO wishlist (user_id, product_id) VALUES ({$info['id']}, $id)");
              http_response_code(201);
            }
          }
          break;
        case 'products':
          if (+$params[2] && $params[3] == 'reviews') {
            $info = JWT::decode();
            if ($info) {
              $errors = [];
              $txt = testInput($_POST['txt']);
              $rating = +$_POST['rating'];
              // Rating validation
              $rating < 1 || $rating > 5 && $errors[] = 'Rating must be between 1 and 5 digit';
              // Text validation
              if (!$txt)
                $errors[] = "Text can't be blank";
              elseif (strlen($txt) > 1000)
                $errors[] = 'Text length should not exceed 1000';
              // If errors not exist
              if (empty($errors) && mysqli_num_rows(mysqli_query($connect, "SELECT id FROM products WHERE id = $params[2]"))) {
                // Insert review
                mysqli_query($connect, "INSERT INTO reviews (user_id, product_id, text, rating) VALUES ({$info['id']}, $params[2], '$txt', $rating)");
                http_response_code(201);
                echo 'Thanks For Your Review';
              } else {
                http_response_code(400);
                echo json_encode($errors);
              }
            }
          }
          break;
        case 'contact':
          $errors = [];
          $fullName = testInput($_POST['fullName']);
          $email = testInput($_POST['email']);
          $txt = testInput($_POST['txt']);
          // Full name validation
          !preg_match('/^[a-z]+\s[a-z]+$/i', $fullName) &&
            $errors[] = 'Only allows letters and a space between full name';
          // Email validation
          !filter_var($email, FILTER_VALIDATE_EMAIL) &&
            $errors[] = 'Invalid email format';
          // Text validation
          if (!$txt)
            $errors[] = "Text can't be blank";
          elseif (strlen($txt) > 1000)
            $errors[] = 'Text length should not exceed 1000';
          // If errors empty
          if (empty($errors)) {
            // If the letter is sent set success or error msg
            if (mail('support@f-mania.com', 'Contact F-mania', $txt, "From: $email")) {
              echo 'Thanks For Your Message';
              return http_response_code(200);
            } else $errors[] = 'Oops, subscription unsuccessful. Please try again';
          }
          // If errors exist will show it
          http_response_code(400);
          echo json_encode($errors);
          break;
        case 'subscribers':
          $error = '';
          $email = testInput($_POST['email']);
          // Validate email
          if (!filter_var($email, FILTER_VALIDATE_EMAIL))
            $error = 'Invalid email format';
          // Check for sending email
          elseif (mail(
            $email,
            'Thank you for subscribing to our F-mania',
            "For questions about this list, please contact:\r\nsupport@f-mania.com",
            'From: support@f-mania.com'
          )) {
            mysqli_query($connect, "INSERT IGNORE INTO subscribers (email) VALUES ('$email')");
            echo "Congratulations! You're on our subscription list now";
            return http_response_code(200);
          } else $error = 'Oops, subscription unsuccessful. Please try again';
          // If error exist will show it
          http_response_code(400);
          echo $error;
      }
      break;
    case 'PUT':
      switch ($params[1]) {
        case 'account':
          $info = JWT::decode();
          // If JWT is valid
          if ($info) {
            $data = [];
            $input = json_decode(file_get_contents('php://input'), true);
            $firstName = testInput($input['firstName']);
            $lastName = testInput($input['lastName']);
            $email = testInput($input['email']);
            $phone = $input['phone'];
            // First name validation
            !preg_match('/^[a-z]+$/i', $firstName) &&
              $data['errors'][] = 'Only letters allowed in First Name';
            // Last name validation
            !preg_match('/^[a-z]+$/i', $lastName) &&
              $data['errors'][] = 'Only letters allowed in Last Name';
            // Email validation
            if (!filter_var($email, FILTER_VALIDATE_EMAIL))
              $data['errors'][] = 'Invalid email format';
            elseif ($email != $info['email'] && mysqli_num_rows(mysqli_query($connect, "SELECT id FROM users WHERE email = '$email'")))
              $data['errors'][] = 'This email address is already associated with an account';
            // Phone validation
            if ($phone) {
              if (!preg_match('/^[0-9]+$/', $phone))
                $data['errors'][] = 'Only digits allowed in phone number';
              elseif (strlen($phone) > 15)
                $data['errors'][] = 'Maximum phone number length 15';
            }
            // If empty errors update user info in db
            if (isset($data['errors']))
              http_response_code(400);
            else {
              // Update user info
              mysqli_query($connect, "UPDATE users SET firstName = '$firstName', lastName = '$lastName', email = '$email', phone = $phone WHERE id = {$info['id']}");
              $data['JWT'] = JWT::encode([
                'id' => $info['id'],
                'firstName' => $firstName,
                'lastName' => $lastName,
                'email' => $email,
                'phone' => $phone
              ]);
              $data['msg'] = 'Your personal information has been updated';
              http_response_code(200);
            }
            echo json_encode($data);
          }
          break;
        case 'cart': 
          if (+$params[2]) {
            $info = JWT::decode();
            // If JWT is valid
            if ($info) {
              $quantity = +file_get_contents('php://input');
              $maxQuantity = mysqli_fetch_assoc(
                mysqli_query(
                  $connect,
                  "SELECT o.quantity FROM cart c JOIN offers o WHERE c.id = $params[2] AND c.user_id = {$info['id']} AND o.product_id = c.product_id AND o.color_id = c.color_id AND o.size_id = c.size_id"
                )
              )['quantity'];
              // Validate quantity
              if ($quantity < 1) $quantity = 1;
              elseif ($quantity > $maxQuantity) $quantity = $maxQuantity;
              // Update cart
              mysqli_query($connect, "UPDATE cart SET quantity = $quantity WHERE id = $params[2] AND user_id = {$info['id']}");
              http_response_code(204);
            }
          } else http_response_code(400);
      }
      break;
    case 'DELETE':
      switch ($params[1]) {
        case 'cart':
          if (+$params[2]) {
            $info = JWT::decode();
            // If JWT is valid
            if ($info) {
              // Delete product from cart
              mysqli_query($connect, "DELETE FROM cart WHERE id = $params[2] AND user_id = {$info['id']}");
              http_response_code(204);
            }
          } else http_response_code(400);
          break;
        case 'wishlist':
          if (+$params[2]) {
            $info = JWT::decode();
            // If JWT is valid
            if ($info) {
              // Delete product from wishlist
              mysqli_query($connect, "DELETE FROM wishlist WHERE user_id = {$info['id']} AND product_id = $params[2]");
              http_response_code(204);
            }
          } else http_response_code(400);
      }
  }
}
