---
title: User Management
template: default
---

# Guide: Manage Users

Murano user management supports user authentication, role-based access control, and storage per user. This guide will give simple examples for managing users under your solution with [User Management Service](http://docs.exosite.com/reference/services/user/).

# Prerequisites

1. You will need a solution to follow these examples step by step.
2. You will need to install Murano CLI [https://github.com/exosite/MuranoCLI] to deploy your solution.
3. You will need to add the following functions to 'my_library' of MODULES for reuse. Use Murano CLI to syncdown your solution, then put this code into **modules/my_library.lua**
   ```lua
    function find_user_by_email(email)
      -- This function is for finding user by email, which makes use of the filter of user listing operation.
      local result = User.listUsers({filter="email::like::"..email})

      if tostring(result) == "[]" or result[1] == nil then
        return nil
      end

      return result[1]
    end

    function get_current_user(request)
      -- This function is to get current logged-in user, which is saved by token in browser cookie.
      local headers = request.headers
      if type(headers.cookie) ~= "string" then
        return nil
      end
      local _, _, sid = string.find(headers.cookie, "sid=([^;]+)")
      if type(sid) ~= "string" then
        return nil
      end
      local user = User.getCurrentUser({token = sid})
      if user ~= nil and user.id ~= nil then
        user.token = sid
        return user
      end
      return nil
    end

    function random_capital_string(length)
      -- This function is a simple way to create password or token for example use. For your online solution, please replace with safer token generator if possible.
      math.randomseed(os.time())
      local a = {}
      for count = 1, length do
        a[#a+1] = string.char(math.random(65,90))
      end
      return table.concat(a)
    end
   ```

# User

## User Signup

In this example, you will add the user-signup feature to your solution. Validating a new user requires at least two steps—creation and activation. A user is unable to log in until activated. Thus, the signup process here will be:

1. A user submits their email, name, and password.

2. Your solution sends the user an email containing an activation link to verify their email address.

3. The user clicks the activation link to finish the signup process.

## User Implementation

1. Prepare an endpoint for user creation to be called when a user submits their email, name, and password.

    For use of Murano CLI, create endpoint  **endpoints/api-user-signup.post.lua** and input the following code.
    ```lua
    --#ENDPOINT POST /api/user/signup
    local email = request.body.email
    local name = request.body.name
    local password = request.body.password

    local ret = User.createUser({
      email = email,
      name = name,
      password = password
    })
    if ret.error ~= nil then
      -- Failed to create user
      response.code = ret.status
      response.message = ret.error
    else
      -- Succeeded in creating user and got the activation code.
      local activation_code = ret
      local domain = Config.solution().domain
      local text = "Hi " .. email .. ",\n"
      text = text .. "Click this link to verify your account:\n"
      -- Include activation link in email
      text = text .. "https://" .. domain .. "/api/verify/" .. activation_code;
      -- Mail to the user for email verification
      Email.send({
        from = 'Sample App <mail@exosite.com>',
        to = email,
        subject = ("Signup on " .. domain),
        text = text
      })
    end
    ```
2. Create an endpoint for activating users. This endpoint should be the same as the link in the signup email. Users are directed to this endpoint by clicking the link in the email they receive from signup.

    For use of Murano CLI, create endpoint **endpoints/api-verify-{code}.get.lua** and put the following code into it.
    ```lua
    --#ENDPOINT GET /api/verify/{code}
    local ret = User.activateUser({code = request.parameters.code})
    if ret == 'OK' then
      response.message = "Sign up succeeded"
    else
      response.code = 401
      response.message = 'Sign up failed. Error: ' .. ret.message
    end
    ```

3. Set up a user-signup page as UI.

   For use of Murano CLI, create file **files/signup.html** and put the following code into it (on this page, there is a 	simple form for input of email, name, and password).

     ```html
     <!DOCTYPE html>
        <html lang="en">
        	<head>
        		<meta charset="utf-8">
        		<meta http-equiv="X-UA-Compatible" content="IE=edge">
        		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        		<meta name="description" content="">
        		<meta name="author" content="">

        		<title>Signup</title>

        		<!-- Bootstrap core CSS -->
        		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        	</head>

        	<body>

        		<div class="container">

        			<form id="nav-signup" method="POST" action="/api/user/signup" >

        				<div class="form-group nav-signedout">
        					<label for="email">Email: </label>
        					<input type="text" class="form-control" name="email" id="email" placeholder="Email" required="true" />
        				</div>
        				<div class="form-group nav-signedout">
        					<label for="name">Name: </label>
        					<input type="text" class="form-control" name="name" id="name" placeholder="Name" required="true" />
        				</div>
        				<div class="form-group nav-signedout">
        					<label for="password">Password: </label>
        					<input type="password" class="form-control" name="password" id="password" placeholder="Password" required="true" />
        				</div>
        				<button type="submit" class="btn btn-default nav-signedout" id="sign-up">Sign Up</button>
        			</form>

        		</div><!-- /.container -->


        		<!-- Bootstrap core JavaScript
        		================================================== -->
        		<!-- Placed at the end of the document so the pages load faster -->
        		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous"></script>
        		<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js" integrity="sha384-Plbmg8JY28KFelvJVai01l8WyZzrYWG825m+cZ0eDDS1f7d/js6ikvy1+X+guPIB" crossorigin="anonymous"></script>
        		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
                <script>
                        $(function(){
                                function signUp() {
                                        console.log('signing up...');
                                        $.ajax({
                                                method: 'POST',
                                                url: '/api/user/signup',
                                                data: JSON.stringify({email: $('#email').val(), name: $('#name').val(), password: $('#password').val()}),
                                                headers: {
                                                        'Content-Type': 'application/json'
                                                },
                                                success: function(data) {
                                                        alert("You should soon receive an email with a validation token.");
                                                },
                                                error: function(xhr, textStatus, errorThrown) {
                                                        const errorRes = jQuery.parseJSON(xhr.responseText);
                                                        alert(errorRes.message);
                                                }
                                        });
                                }
                                $('#nav-signup').submit(function(){
                                        signUp();
                                        return false;
                                });
                        });
                </script>
        	</body>
        </html>
     ```

4. Deploy the local change by command **murano syncup -V**.

      You should now be able to sign up.

      Go to the user-signup page [https://&lt;your_domain_name&gt;/signup.html]. You will see a form for signup.

      ![User Signup](../assets/user-signup.png)

      Fill out the form and submit. You will then receive an email for activation.

      ![User Activation](../assets/user-activation-email.png)

      Click the link to be directed to your solution. You should receive a success message that user signup is complete.

## User Password Reset

   Users are only human and may occasionally forget their password. This example will help you implement user-password reset with the following process:

  1. A user requests forget-password by email. The solution sends the token to the user.
  2. The user receives the token and then uses the token to set their password directly.

Now, you may implement with the following steps.

1. You will need an endpoint to be called when a user requests forget-password.

    For use of Murano CLI, create endpoint **endpoints/api-forgotten.post.lua** and put the following code into it.
    ```lua
    --#ENDPOINT POST /api/forgotten

    if request.body.email == nil then
      response.code = 400
      response.message = "Email missing"
      return
    end

    -- Check if the email exists
    local user = find_user_by_email(request.body.email)
    if (user == nil) then
      response.code = 404
      response.message = "User not found"
      return
    end

    -- Generate Token and send email.
    -- That links to reset page, which validates token, and asks for new pasword and resets.

    local resetToken = random_capital_string(50)

    -- Save the token.
    local ret = Keystore.set{key = resetToken, value = user.id}
    if ret.status ~= nil then
      response.code = ret.status
      response.message = ret
      return
    end
    -- Have the Reset Token expire after 24 hours.
    Keystore.command{key = resetToken, command = 'EXPIRE', args = { 24*3600 }}

    local domain = Config.solution().domain
    local text = "Hi " .. user.email .. ",\n"
    text = text .. "Click this link to reset your password\n"
    -- Add Reset Token to query string of the link URL
    text = text .. "https://" .. domain .. "/resetPassword.html?rt=" .. resetToken;
    Email.send({
      from = 'Sample App <mail@exosite.com>',
      to = user.email,
      subject = ("Password reset request from " .. domain),
      text = text
    })
    ```

2. Create an endpoint for setting a password directly by reset token.

    For use of Murano CLI, create endpoint **endpoints/api-resetPassword.post.lua** and put the following code into it.
    ```lua
    --#ENDPOINT POST /api/resetPassword
    if request.body.resetToken == nil then
      response.code = 400
      response.message = "Missing reset token"
      return
    end

    if request.body.password == nil then
      response.code = 400
      response.message = "Missing new password"
      return
    end

    local found = Keystore.get{key = request.body.resetToken}
    if found.value == nil then
      response.code = found.status
      response.message = "Invalid Token"
      response.code = 400
      return
    end

    local ret = User.resetUserPassword{
      id = found.value,
      password = request.body.password
    }
    if ret.status ~= nil then
      -- Failed to reset password
      response.code = ret.status
      response.message = ret
      return
    end

    Keystore.delete{key = request.body.resetToken}
    -- Reset successfully
    return ret
    ```
  * For UI, there are two pages: one is for users to request by submiting an email; the other is for requesters to set a new password.

3. Create file **files/forgotten.html** and put the following code into it (on this page, there is only an input for email address).

    ```html
    <!DOCTYPE html>
    <html lang="en">
    	<head>
    		<meta charset="utf-8">
    		<meta http-equiv="X-UA-Compatible" content="IE=edge">
    		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    		<meta name="description" content="">
    		<meta name="author" content="">

    		<title>Forgot Password</title>

    		<!-- Bootstrap core CSS -->
    		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    	</head>

    	<body>

    		<div class="container">

    			<form id="nav-forgot" method="POST" action="/api/forgotten" >

    				<div class="form-group nav-signedout">
    					<label for="email">Email: </label>
    					<input type="text" class="form-control" name="email" id="email" placeholder="Email" required="true" />
    				</div>
    				<button type="submit" class="btn btn-default" id="forgot">Forgot Password</button>
    			</form>

    		</div><!-- /.container -->


    		<!-- Bootstrap core JavaScript
    		================================================== -->
    		<!-- Placed at the end of the document so the pages load faster -->
    		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous"></script>
    		<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js" integrity="sha384-Plbmg8JY28KFelvJVai01l8WyZzrYWG825m+cZ0eDDS1f7d/js6ikvy1+X+guPIB" crossorigin="anonymous"></script>
    		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
            <script>
                    $(function(){
                            function forgotPassword() {
                                    $.ajax({
                                            method: 'POST',
                                            url: '/api/forgotten',
                                            data: JSON.stringify({email: $('#email').val()}),
                                            headers: { 'Content-Type': 'application/json' },
                                            success: function(data) {
                                                    alert("You should soon receive an email with a reset link.");
                                            },
                                            error: function(xhr, textStatus, errorThrown) {
                                                    console.log(xhr.responseText);
                                            }
                                    });
                            }

                            $('#nav-forgot').submit(function(){
                                    forgotPassword();
                                    return false;
                            });
                    });
            </script>
    	</body>
    </html>
    ```
4. Create another page **files/resetPassword.html** and put the following code into it (in this page, there is only an input for new password, but it is assumed to have a Reset Token in the query string when being opened by the requester).

    ```html
    <!DOCTYPE html>
    <html lang="en">
    	<head>
    		<meta charset="utf-8">
    		<meta http-equiv="X-UA-Compatible" content="IE=edge">
    		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    		<meta name="description" content="">
    		<meta name="author" content="">

    		<title>Reset Password</title>

    		<!-- Bootstrap core CSS -->
    		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    	</head>

    	<body>

    		<div class="container">

    			<form id="nav-reset-password" method="POST" action="/api/resetPassword" >
    				<div class="form-group nav-signedout">
    					<label for="password">New Password: </label>
    					<input type="password" class="form-control" name="password" id="password" placeholder="New Password" required="true" />
    				</div>
    				<button type="submit" class="btn btn-default" id="changePassword">Change</button>
    			</form>

    		</div><!-- /.container -->


    		<!-- Bootstrap core JavaScript
    		================================================== -->
    		<!-- Placed at the end of the document so the pages load faster -->
    		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous"></script>
    		<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js" integrity="sha384-Plbmg8JY28KFelvJVai01l8WyZzrYWG825m+cZ0eDDS1f7d/js6ikvy1+X+guPIB" crossorigin="anonymous"></script>
    		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
            <script>
                $(function(){
                            var resetToken = null;

                            function changePassword() {
                                $.ajax({
                                        method: 'POST',
                                        url: '/api/resetPassword',
                                        data: JSON.stringify({
                                                resetToken: resetToken,
                                                password: $('#password').val()
                                        }),
                                        headers: { 'Content-Type': 'application/json' },
                                        success: function(data) {
                                                alert('Changed');
                                        },
                                        error: function(xhr, textStatus, errorThrown) {
                                                try {
                                                        const errorRes = jQuery.parseJSON(xhr.responseText);
                                                        alert(errorRes.message);
                                                } catch (e){
                                                        alert(xhr.responseText);
                                                }
                                        }
                                });
                        }

                        $('#nav-reset-password').submit(function(){
                                changePassword();
                                return false;
                        });

                        function getParameterByName(name, url) {
                                if (!url) {
                                        url = window.location.href;
                                }
                                name = name.replace(/[\[\]]/g, "\\$&");
                                var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                                        results = regex.exec(url);
                                if (!results) return null;
                                if (!results[2]) return '';
                                return decodeURIComponent(results[2].replace(/\+/g, " "));
                        }

                        resetToken = getParameterByName('rt');

                });
            </script>
    	</body>
    </html>
    ```

5. Deploy the local change by command **murano syncup -V**.

    A password can now be reset.

    1. Go to forgotten page [https://&lt;your_domain_name&gt;/forgotten.html]. Submit an email address of an existing user.

    	![User Forget Password](../assets/user-forget-password.png)

    2. Receive the email and click the link to set new password.

   	   ![User Reset Password Email](../assets/user-reset-password-email.png)

   	   ![User Reset Password](../assets/user-reset-password.png)

    3. Once you get message "Changed". The user password has been changed.

## User Authentication

The process of solution user identification is:

1. A user uses their **email** and **password** to get a token representing an authenticated user and has an associated time-to-live(ttl).

2. A token can be used to get the user basic information such as user.id, user.email, user.name, etc.

## User Login

This example will help you implement the user-login feature, which will display a user login and profile page.

1. Create an endpoint to be called when a user submits their email and password.

    For use of Murano CLI, create endpoint **endpoints/api-session-login.post.lua** and input the following code.

    ```lua
    --#ENDPOINT POST /api/session/login
    -- Clear browser cookie to logout current user
    response.headers = {
      ["Set-Cookie"] = "sid=; path=/;"
    }
    -- Authenticate by email and password
    local ret = User.getUserToken({
      email = request.body.email,
      password = request.body.password
    })
    -- If email and password match, it will return a token.
    if ret.error ~= nil then
       response.code = 401
      response.message = "Auth failed"
    else
      local domain = Config.solution().domain
      response.code = 303
        -- Save token as current user in browser cookie
        response.headers = {
          ["Set-Cookie"] = "sid=" .. tostring(ret).."; path=/;",
          ["Location"] = "https://" .. domain .. "/api/session/user"
        }
    end
    ```
2. Create an endpoint for returning current user info. This can be used to check logged-in users for access restrictions.

    For use of Murano CLI, create endpoint  **endpoints/api-session-user.get.lua** and input the following code.

    ```lua
    --#ENDPOINT GET /api/session/user
    local user = get_current_user(request)
    if user ~= nil and user.id ~= nil then
      response.headers = {
        ["Cache-Control"] = 'no-cache',
      }
      response.message = user
    else
      response.code = 400
      response.message = "Session invalid"
    end
    ```

3. For the login page, create file **files/login.html** and input the following code (in this page, there is a form for submitting email and password).

    ```html
    <!DOCTYPE html>
    <html lang="en">
    	<head>
    		<meta charset="utf-8">
    		<meta http-equiv="X-UA-Compatible" content="IE=edge">
    		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    		<meta name="description" content="">
    		<meta name="author" content="">

    		<title>Login</title>

    		<!-- Bootstrap core CSS -->
    		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    	</head>

    	<body>

    		<div class="container">

    			<form id="nav-login" method="POST" action="/api/session/login" >

    				<div class="form-group nav-signedout">
    					<label for="email">Email: </label>
    					<input type="text" class="form-control" name="email" id="email" placeholder="Email" required="true" />
    				</div>
    				<div class="form-group nav-signedout">
    					<label for="password">Password: </label>
    					<input type="password" class="form-control" name="password" id="password" placeholder="Password" required="true" />
    				</div>
    				<button type="submit" class="btn btn-default nav-signedout" id="login">Login</button>
    			</form>

    		</div><!-- /.container -->


    		<!-- Bootstrap core JavaScript
    		================================================== -->
    		<!-- Placed at the end of the document so the pages load faster -->
    		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous"></script>
    		<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js" integrity="sha384-Plbmg8JY28KFelvJVai01l8WyZzrYWG825m+cZ0eDDS1f7d/js6ikvy1+X+guPIB" crossorigin="anonymous"></script>
    		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
            <script>
                    $(function(){
                            function login() {
                                    console.log('logging in...');
                                    $.ajax({
                                            method: 'POST',
                                            url: '/api/session/login',
                                            data: JSON.stringify({email: $('#email').val(), password: $('#password').val()}),
                                            headers: {
                                                    'Content-Type': 'application/json'
                                            },
                                            success: function(data) {
                                                    window.location.href = 'profile.html';
                                            },
                                            error: function(xhr, textStatus, errorThrown) {
                                                    alert(xhr.responseText);
                                            }
                                    });
                            }
                            $('#nav-login').submit(function(){
                                    login();
                                    return false;
                            });
                    });
            </script>
    	</body>
    </html>
    ```

4. For the profile page, create file **files/profile.html** and input the following code.

    ```html
    <!DOCTYPE html>
    <html lang="en">
    	<head>
    		<meta charset="utf-8">
    		<meta http-equiv="X-UA-Compatible" content="IE=edge">
    		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    		<meta name="description" content="">
    		<meta name="author" content="">

    		<title>Login</title>

    		<!-- Bootstrap core CSS -->
    		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    	</head>

    	<body>

    		<div class="container">
                            <h2>My Profile</h2>
                            <table id="user-info" class="table table-hover">
                                    <tbody>
                                    </tbody>
                            </table>
                            <button type="button" class="btn btn-default" id="Logout">Logout</button>
    		</div><!-- /.container -->


    		<!-- Bootstrap core JavaScript
    		================================================== -->
    		<!-- Placed at the end of the document so the pages load faster -->
    		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous"></script>
    		<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js" integrity="sha384-Plbmg8JY28KFelvJVai01l8WyZzrYWG825m+cZ0eDDS1f7d/js6ikvy1+X+guPIB" crossorigin="anonymous"></script>
    		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
            <script>
                    $(function(){
                            function checkSession() {
                                    $.ajax({
                                            method: 'GET',
                                            url: '/api/session/user',
                                            success: function(user) {
                                                    loadProfileDetails(user);
                                            },
                                            error: function(xhr, textStatus, errorThrown) {
                                                    console.log("Session check failed.");
                                                    window.location.href = "login.html";
                                            }
                                    });
                            }

                            function loadProfileDetails(user) {
                                    $(Object.keys(user)).each(function(index, name){
                                            const title = $("<th />").text(name);
                                            const value = $("<td />").text(user[name]);
                                            const row = $("<tr />").append(title).append(value);
                                            $('#user-info tbody').append(row);
                                    });
                            }

                            function logout() {
                                    $.ajax({
                                            method: 'POST',
                                            url: '/api/session/login',
                                            data: JSON.stringify({email: "inavlid", password: "invalid"}),
                                            headers: {
                                                    'Content-Type': 'application/json'
                                            },
                                            error: function(xhr, textStatus, errorThrown) {
                                                    window.location.href = "login.html";
                                            }
                                    });
                            }

                            $('#Logout').click(function() {
                                logout();
                            });
                            checkSession();
                    });
            </script>
    	</body>
    </html>
    ```

5. Deploy the local change by command **murano syncup -V**.

    You are now able to log in.

    1. Go to the login page [https://&lt;your_domain_name&gt;/login.html]. Submit your email and password.

    	![User Login](../assets/user-login.png)

    2. With the correct email and password, you should log in successfully and be redirected to the profile page 	[https://&lt;your_domain_name&gt;/profile.html].

    	![User Profile](../assets/user-profile.png)

    3. Click the logout button, and you will be redirected to the login page.

# Role

## Role Creation

Assumption:
You want to provide differentiated info of a user depending on different roles. An owner should be able to see all info while a guest is restricted to partial info. Here is the code you can use to initiate roles for this example.

Please create endpoint **endpoints/_init.get.lua**.

If your solution does not have it, then put/merge the following code into it.

```lua
--#ENDPOINT GET /_init
-- Create a role represents 'owner'
local owner_role = {role_id = "owner"}
User.createRole(owner_role)

-- Create a role represents 'guest'
local guest_role = {role_id = "guest"}
User.createRole(guest_role)

-- Add parameter 'infoUserId' to specify user for info retrieve, thus you can assign roles with specific user IDs later on.
local add_owner_info_user_id = {
  role_id = "owner",
  body = {
    {
      name = "infoUserId"
    }
  }
}
User.addRoleParam(add_owner_info_user_id)

local add_guest_info_user_id = {
  role_id = "guest",
  body = {
    {
      name = "infoUserId"
    }
  }
}
User.addRoleParam(add_guest_info_user_id)
```

To create roles above, please deploy by command **murano syncup -V** and then go to endpoint [https://<your_domain_name>/_init] for executing the code.

## Role Assignment

Assumption:
Bearing on Role-Creation, you have created two roles (**owner** and **guest**) for differentiating user info retrieved. Now you can grant differing access by role assignement. In this example, a user is assumed to be assigned roles once created.

Please modify the file **endpoints/api-user-signup.post.lua** from User-Signup example and input the following code.

```lua
--#ENDPOINT POST /api/user/signup
local email = request.body.email
local name = request.body.name
local password = request.body.password

local ret = User.createUser({
  email = email,
  name = name,
  password = password
})
if ret.error ~= nil then
  -- Failed to create user
  response.code = ret.status
  response.message = ret.error
else
  -- Succeeded in user creation and got the activation code.

  -- Assign roles to this new user
  local new_user = find_user_by_email(email)
  local assign_info_user_id = {
    id = new_user.id,
    roles = {
      {
        -- Assign role 'owner' to let the created user be owner of himself
        role_id = "owner",
        parameters = {
          {
            name = "infoUserId",
            value = new_user.id
          }
        }
      },
      {
        -- Assign role 'guest' to let the created user be guest to other users.
        role_id = "guest",
        parameters = {
          {
            name = "infoUserId",
            value = {
              type = "wildcard"
            }
          }
        }
      }
    }
  }
  User.assignUser(assign_info_user_id)


  local activation_code = ret
  local domain = Config.solution().domain
  local text = "Hi " .. email .. ",\n"
  text = text .. "Click this link to verify your account:\n"
  -- Include activation link in email
  text = text .. "https://" .. domain .. "/api/verify/" .. activation_code;
  -- Mail to the user for email verification
  Email.send({
    from = 'Sample App <mail@exosite.com>',
    to = email,
    subject = ("Signup on " .. domain),
    text = text
  })
end
```

Please deploy the local change again by command **murano syncup -V**.

Now, every new user signing up through **/api/user/signup** will be granted user info access.

To see how it works, move on to the next example.

## Role Check

Assumption:
Bearing on Role-Assignment, a new user will be granted differing user info access. This example will focus on how you check a resource access by assigned roles. You will implement a page for email query. The info returned depends on which roles the current user has.

The following is a table listing the details available for each role.

| Access Role  | User Info Retrieved |
|---|---|
| Logged-in User is Owner  | user.id, user.name, user.email, user.status, user.creation_date, user.roles  |
| Logged-in User is Guest  | user.email, user.creation_date  |
| Logged-in User without relevant roles | user.email  |
| Public / Not Logged-in User | Message "Email <user.email> has already been taken."  |

1. Create an endpoint for returning user info when submitting an email.

    Please create endpoint **endpoints/api-user-info-{email}.get.lua** and input the following code.

    ```lua
    --#ENDPOINT GET /api/user/info/{email}
    local current_user = get_current_user(request)
    local info_user = find_user_by_email(request.parameters.email)

    if (current_user == nil) then
      -- There is no current user
      if (info_user == nil) then
        response.message = "Email " .. request.parameters.email .. " is available."
      else
        response.message = "Email " .. request.parameters.email .. " has already been taken."
      end
      return
    end

    if (info_user == nil) then
      response.message = "Not Found"
      response.code = 404
      return
    end

    local check_current_user_has_owner_role = {
      id = current_user.id,
      role_id = "owner",
      parameter_name = "infoUserId",
      parameter_value = info_user.id
    }
    local owner_role_check_result = User.hasUserRoleParam(check_current_user_has_owner_role)
    if (owner_role_check_result.error == nil) then
      -- is owner
      local user_info_for_owner = info_user
      -- get roles of the user
      local roles_of_user = User.listUserRoles({id = info_user.id})
      -- add further info about roles of the user
      user_info_for_owner.roles = roles_of_user
      response.message = user_info_for_owner
      return
    end

    local check_current_user_has_guest_role = {
      id = current_user.id,
      role_id = "guest",
      parameter_name = "infoUserId",
      parameter_value = info_user.id
    }
    local guest_role_check_result = User.hasUserRoleParam(check_current_user_has_guest_role)
    if (guest_role_check_result.error == nil) then
      local user_info_for_guest = {
        email = info_user.email,
        creation_date = info_user.creation_date
      }
      response.message = user_info_for_guest
      return
    end

    response.message = {
      email = info_user.email
    }
    ```
2. Create a query page for submiting an email address.
    Please create file **files/queryEmail.html** and put the following code into it.
    ```html
    <!DOCTYPE html>
    <html lang="en">
    	<head>
    		<meta charset="utf-8">
    		<meta http-equiv="X-UA-Compatible" content="IE=edge">
    		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    		<meta name="description" content="">
    		<meta name="author" content="">

    		<title>Query Email</title>

    		<!-- Bootstrap core CSS -->
    		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    	</head>

    	<body>

    		<div class="container">

    			<form id="nav-query-email">
    				<div class="form-group nav-signedout">
    					<label for="email">Email: </label>
    					<input type="email" class="form-control" name="email" id="email" placeholder="Email" required="true" />
    				</div>
    				<button type="submit" class="btn btn-default" id="query_email">Query</button>
    			</form>
                            <div class="container">
                                    <h2>Info of Email</h2>
                                    <table id="user-info" class="table table-hover">
                                            <tbody>
                                            </tbody>
                                    </table>
                            </div>

    		</div><!-- /.container -->


    		<!-- Bootstrap core JavaScript
    		================================================== -->
    		<!-- Placed at the end of the document so the pages load faster -->
    		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous"></script>
    		<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js" integrity="sha384-Plbmg8JY28KFelvJVai01l8WyZzrYWG825m+cZ0eDDS1f7d/js6ikvy1+X+guPIB" crossorigin="anonymous"></script>
    		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
            <script>
                    $(function(){
                            function queryEmail() {
                                    $('#user-info tbody').text('');
                                    $.ajax({
                                            method: 'GET',
                                            url: '/api/user/info/'+$('#email').val(),
                                            success: function(info) {
                                                    if (jQuery.type(info) === 'string') {
                                                        loadInfo({'-': info});
                                                        return;
                                                    }
                                                    loadInfo(info);
                                            },
                                            error: function(xhr, textStatus, errorThrown) {
                                                    loadInfo({'-': xhr.responseText});
                                            }
                                    });
                            }

                            function loadInfo(info) {
                                    $(Object.keys(info)).each(function(index, name){
                                            const titleField = $("<th />").text(name);
                                            const value = jQuery.type(info[name]) === 'array' ? JSON.stringify(info[name]) : info[name];
                                            const valueField = $("<td />").text(value);
                                            const row = $("<tr />").append(titleField).append(valueField);
                                            $('#user-info tbody').append(row);
                                    });
                            }


                            $('#nav-query-email').submit(function() {
                                queryEmail();
                                return false;
                            });
                    });
            </script>
    	</body>
    </html>
    ```

    Now you can deploy the local change and then try on the query page.

    1. Go to [https://&lt;your_domain_name&gt;/queryEmail.html] without login. Query with an existing email address.

        ![Query Email by Public](../assets/query-email-by-public.png)

    2. Next, sign up at [https://<your_domain_name>/signup.html] from example User-Signup for getting a new user that has been assigned with roles.

    3. Log in with the new user at [https://&lt;your_domain_name&gt;/login.html] from example User-Login and then back to [https://&lt;your_domain_name&gt;/queryEmail.html] to query with your email address. Because the current user has owner role, it will return full info.

        ![Query Email by Owner](../assets/query-email-by-owner.png)

    4. Lastly, query with another existing email address—as a guest you will only get partial info.

        ![Query Email by Guest](../assets/query-email-by-guest.png)

## User Permission

User permission is based on [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control).
In this system, there are three concrete elements: &rsquo;role&rsquo;, &rsquo;user&rsquo;, and &rsquo;endpoint&rsquo;. According to RBAC, you can control a user&rsquo;s access to endpoint with the concept below:

1. Assign endpoint to role
2. Assign role to user
3. User can access the endpoint of their role

![User Diagram 1](../assets/user_1.png)

However, URL can be different in variable practically. For example, &rsquo;*device/1/info*&rsquo; and &rsquo;*device/2/info*&rsquo; are different literally but can be considered the same endpoint. You do not want to create two endpoints for such a difference. That is why the fourth element called &rsquo;parameter&rsquo; is added.

&rsquo;Parameter&rsquo; represents a specific resource by name and value. It is marked as {&lt;parameter_name&gt;} in endpoint. Here, the creation of only one endpoint &rsquo;device/{rid}/info&rsquo; for &rsquo;*device/1/info*&rsquo; and &rsquo;*device/2/info*&rsquo; is needed.
When user permission is granted, it is necessary to specify parameters for each role assignment.

![User Diagram 2](../assets/user_2.png)

If you want to grant &rsquo;UserA&rsquo; access to &rsquo;*device/1/info*&rsquo;, you can:

1. Create a role called &rsquo;Viewer&rsquo;.
2. Add parameter definition &rsquo;rid&rsquo; to role &rsquo;Viewer&rsquo;, which means parameter &rsquo;rid&rsquo; is available in role &rsquo;Viewer&rsquo;.
3. Assign endpoint &rsquo;*device/{rid}/info*&rsquo; to role &rsquo;Viewer&rsquo;.
4. Assign role &rsquo;Viewer&rsquo; with parameter &rsquo;rid&rsquo;(name) = 1(value) to &rsquo;UserA&rsquo;.
5. Now UserA is allowed access to &rsquo;*device/1/info*&rsquo; when you check their permission.

## Storage Per User

The provided storage per user stores data by key-value format. Since a user&rsquo;s properties are only email and name, you can put more individual information in storage (e.g., address, birthday, etc.).

# <span id="head_tutorial_example">Tutorial Example in Scripting System</span>

Assume you are running a parking application.
There are two major roles in your system. One: the driver wants to park their vehicle. Two: the parking lot/garage charges drivers for parking.

To separate their permission, you should create at least two roles.
###### <span id="eg_createRole"></span>
```lua
-- Create role 'vehicle_driver' for driver
local role_vehicle_driver = {
    ["role_id"] = "vehicle_driver"
}
User.createRole(role_vehicle_driver)

-- Create role 'parking_area_manager'
local role_parking_area_manager = {
    ["role_id"] = "parking_area_manager"
}
User.createRole(role_parking_area_manager)
```

Suppose you have two users:

**User\_Parking\_Area** is in role &rsquo;parking_area_manager&rsquo; and has unique ID = **1**.

###### <span id="eg_createUser"></span>
```lua
-- Create User_Parking_Area
local new_user = {
	["name"] = "User_Parking_Area",
	["email"] = "demo_parking_area@exosite.com",
	["password"] = "demo777"
}
local activation_code = User.createUser(new_user)
```

###### <span id="eg_activateUser"></span>

```lua
-- Need to activate user after creating
local parameters = {
	["code"] = activation_code
}
User.activateUser(parameters)

```

**User_Vehicle** is in role &rsquo;vehicle_driver&rsquo; and has unique ID = **2**.

```lua
-- Create User_Vehicle
local new_user = {
	["name"] = "User_Vehicle",
	["email"] = "demo_vehicle@exosite.com",
	["password"] = "demo777"
}
local activation_code = User.createUser(new_user)

-- Activate User_Vehicle
local parameters = {
	["code"] = activation_code
}
User.activateUser(parameters)

```

In this tutorial, you will assume each driver has exactly one vehicle. This is a simplification that allows you to respect the User Management focus of this tutorial. You will represent the driver's vehicle data in a keystore record derived from the user's ID.

###### <span></span>
```lua
--- Store User_Vehicle's license plate number
local driver_id = 2 -- User ID of User_Vehicle
parameters = {
    ["key"] = "Driver_"..driver_id.."_Vehicle_License_Plate_Number",
    ["value"] = "QA-7712"
}
Keystore.set(parameters)

-- Initialize User_Vehicle's parking start time
parameters = {
    ["key"] = "Driver_"..driver_id.."_Parking_Start_Time",
    ["value"] = "0000-00-00 00:00:00" -- current parking start time
}
Keystore.set(parameters)

```
### Scenario: List Control
First, support an endpoint for parking areas to manage their parking spaces. This endpoint is expected to list unique IDs of parking spaces.

```lua
-- Create endpoint for listing parking spaces of parking area
local list_parking_space_endpoint = {
    ["method"] = "GET",
    ["end_point"] = "list/{parkingAreaID}/parkingSpace" -- This endpoint contains a parameter name 'parkingAreaID'
}
User.createPermission(list_parking_space_endpoint)

-- Assign endpoint to role 'parking_area_manager', so parking area managers can access it.
local endpoints = {
    ["method"] = "GET",
    ["end_point"] = "list/{parkingAreaID}/parkingSpace"
}
User.addRolePerm({["role_id"] = "parking_area_manager", ["body"] = endpoints})
```

To let **User\_Parking\_Area** access *'GET list/1/parkingSpace'*, grant **User\_Parking\_Area** permisson on 'parkingAreaID' = 1 in role 'parking_area_manager'.

```lua
-- We should add parameter definition before assigning roles with new parameter name.
local param_definitions = {
    {
        ["name"] = "parkingAreaID"
    }
}
User.addRoleParam({["role_id"] = "parking_area_manager",  ["body"] = param_definitions})

-- Grant User_Parking_Area parameter 'parkingAreaID' = 1 in role 'parking_area_manager'
local roles_assigned = {
    {
        ["role_id"] = "parking_area_manager",
        ["parameters"] = {
            {
                ["name"] = "parkingAreaID",
                ["value"] = 1
            }
        }
    }
}
User.assignUser({["id"] = 1, ["roles"] = roles_assigned})
```
Now **User\_Parking\_Area** can access *'GET list/1/parkingSpace'*.

Next, make the list returned in response.

Assume there are two parking spaces in **User\_Parking\_Area**. Each parking space has a device RID. Devices can detect the status of a parking space. You can make **User\_Parking\_Area** have device RIDs by assigning roles.

```lua
-- We should add parameter definition before assigning roles with new parameter name.
local param_definitions = {
    ["role_id"] = "parking_area_manager",
    ["body"] = {
        {
            ["name"] = "spaceRID" -- device RID
        }
    }
}
User.addRoleParam(param_definitions)

-- Grant User_Parking_Area access to his parking space RIDs
local roles_assigned = {
    {
        ["role_id"] = "parking_area_manager",
        ["parameters"] = {
            {
                ["name"] = "spaceRID",
                ["value"] = "d2343hbcc1232sweee12" -- first parking space RID
             },
             {
                ["name"] = "spaceRID",
                ["value"] = "a34feh709a234e232xd21" -- second parking space RID
             }
        }
    }
}
User.assignUser({["id"] = 1, ["roles"] = roles_assigned})
```

After roles assignment, you can return a paginated list of &rsquo;spaceRID&rsquo; when **User\_Parking\_Area** accesses *'GET list/1/parkingSpace'*.

###### <span id="eg_listUserRoleParamValues"></span>
```lua
local parameters = {
    ["id"] = 1, -- User ID of User_Parking_Area
    ["role_id"] = "parking_area_manager",
    ["parameter_name"] = "spaceRID",
    ["offset"] = 0, -- offset for pagination
    ["limit"] = 10 -- limit for pagination
}
local result = User.listUserRoleParamValues(parameters)
response.message = result.items -- return the list of RID
```

### Scenario: Endpoint Access Control
Second, support an endpoint for drivers to look for a vacant parking space. Drivers can query a number of vacancy in every parking area while each parking area manager is restricted to their own.

###### <span id="eg_createPermission"></span>
```lua
-- Create endpoint for querying vacant parking space
local available_space_endpoint = {
    ["method"] = "GET",
    ["end_point"] = "query/{parkingAreaID}/availableSpace" -- The endpoint contains a parameter name 'parkingAreaID'.
}
User.createPermission(available_space_endpoint)
```
###### <span id="eg_addRolePerm"></span>
```lua
-- Assign the endpoint to roles 'vehicle_driver' and 'parking_area_manager', so drivers and parking area managers can access the endpoint.
local endpoints = {
    {
        ["method"] = "GET",
        ["end_point"] = "query/{parkingAreaID}/availableSpace"
    }
}
-- Let drivers access this endpoint
User.addRolePerm({["role_id"] = "vehicle_driver", ["body"] = endpoints})
-- Let parking area managers access this endpoint
User.addRolePerm({["role_id"] = "parking_area_manager", ["body"] = endpoints})
```

To let **User\_Parking\_Area** access *'GET query/1/availableSpace'*, **User\_Parking\_Area** should have parameter 'parkingAreaID' = 1 in role 'parking_area_manager'. Since they have been assigned it before, there is no need to assign again.

To let **User\_Vehicle** access *'GET query/\*/availableSpace'*, you should grant **User\_Vehicle** permission on 'parkingAreaID' = * in role 'vehicle_driver'.

###### <span id="eg_addRoleParam"></span>
```lua
-- To role 'vehicle_driver', parameter name 'parkingAreaID' is new. Before assigning roles with new parameter name, you need to add parameter definition.
local param_definitions = {
    {
        ["name"] = "parkingAreaID"
    }
}
User.addRoleParam({["role_id"] = "vehicle_driver",  ["body"] = param_definitions})
```

###### <span id="eg_assignUser"></span>
```lua
-- Grant User_Vehicle all value of parkingAreaID in role 'vehicle_driver'
local roles_assigned = {
    {
        ["role_id"] = "vehicle_driver",
        ["parameters"] = {
            {
                ["name"] = "parkingAreaID",
                ["value"] = {
                    ["type"] = "wildcard" -- this format represents all values
                }
            }
        }
    }
}
User.assignUser({["id"] = 2, ["roles"] = roles_assigned})
```

Now you can prepare the number returned in response.

You already know there are two parking spaces in **User\_Parking\_Area**. Assume that each parking area is managed by one manager. Thus, info can be stored in keystore storage with the key derived from the manager's ID.

```lua
-- Set number of vacancy info for User_Parking_Area
local manager_id = 1 -- User ID of User_Parking_Area
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy",
    ["value"] = 2 -- Assuming currently there is no vehicle parked in User_Parking_Area.
}
Keystore.set(parameters) -- We store value by Keystore service.
```

When permitted user accesses *'GET  query/1/availableSpace'*, you can return the number.
```lua
-- Get number of vanacy of User_Parking_Area
local manager_id = 1 -- User ID of User_Parking_Area
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy"
}
local number = Keystore.get(parameters)
response.message = number
```


The background process of permission check when the user accesses endpoint can be replicated as follows:
###### <span id="eg_hasUserPerm"></span>
```lua
-- Check if User_Vehicle can access GET query/1/availableSpace.
local check_permission = {
    ["id"] = 2, -- User ID of User_Vehicle
    ["perm_id"] = "GET/query/{parkingAreaID}/availableSpace", -- {method}/{end_point}
    ["parameters"] = {
        "parkingAreaID::1" -- Specifies value 1 for parameter 'parkingAreaID' in endpoint
    }
}
local result = User.hasUserPerm(check_permission)
```

Because **User\_Vehicle** has been assigned with all values of &rsquo;parkingAreaID&rsquo; in role &rsquo;vehicle_driver&rsquo;, variable &rsquo;result&rsquo; is expected to be &rsquo;OK&rsquo;.

```lua
-- Check if User_Parking_Area can access 'GET query/1/availableSpace'.
local check_param = {
    ["id"] = 1, -- User ID of User_Parking_Area
    ["perm_id"] = "GET/query/{parkingAreaID}/availableSpace", -- {method}/{end_point}
    ["parameters"] = {
        "parkingAreaID::1" -- Specifies value 1 for parameter 'parkingAreaID' in endpoint
    }
}
local result = User.hasUserPerm(check_param)
```

Because **User\_Parking\_Area** has been assigned with &rsquo;parkingAreaID = 1&rsquo; in role &rsquo;parking_area_manager&rsquo;, variable &rsquo;result&rsquo; is expected to be &rsquo;OK&rsquo;.

### Scenario: Application of User-storage and Endpoint-access-control

An endpoint for parking area managers to query info of a vehicle, such as parking time or license plate number, is also supported. Each parking area manager can only see info of vehicles parked in their spaces.

```lua
-- Create endpoint 'GET query/{parkingAreaID}/parkingVehicle/{vehicleID}/info'
local vehicle_info_endpoint = {
    ["method"] = "GET",
    ["end_point"] = "query/{parkingAreaID}/parkingVehicle/{vehicleID}/info"
}
User.createPermission(vehicle_info_endpoint)

-- Assign endpoint to role 'parking_area_manager', so parking area managers can access this endpoint.
local endpoints_assigned = {
    {
        ["method"] = "GET",
        ["end_point"] = "query/{parkingAreaID}/parkingVehicle/{vehicleID}/info" -- This endpoint contains a parameter name 'vehicleID'
    }
}
User.addRolePerm({["role_id"] = "parking_area_manager", ["body"] = endpoints_assigned})

-- Add parameter definition 'vehicleID' to role 'parking_area_manager' for assigning role 'parking_area_manager' with parameter 'vehicleID'
local param_definitions = {
    {
        ["name"] = "vehicleID"
    }
}
User.addRoleParam({["role_id"] = "parking_area_manager",  ["body"] = param_definitions})
```

When **User\_Vehicle** parks in **User\_Parking\_Area** (detected by device), **User\_Parking\_Area** should have the right to see info of **User\_Vehicle**.

```lua
-- Since User_Parking_Area already has 'parkingAreaID' = 1 in role 'parking_area_manager', we only need to assign role 'parking_area_manager' with extra parameter 'vehicleID' = 2 to User_Parking_Area.
local roles_assigned = {
    {
        ["role_id"] = "parking_area_manager",
        ["parameters"] = {
            {
                ["name"] = "vehicleID",
                ["value"] = 2 -- User ID of User_Vehicle
            }
        }
    }
}
User.assignUser({["id"] = 1, ["roles"] = roles_assigned})
```

###### <span id="eg_updateUserData"></span>
```lua
-- Add parking info for User_Vehicle
local driver_id = 2 -- User ID of User_Vehicle
parameters = {
    ["key"] = "Driver_"..driver_id.."_Parking_Start_Time",
    ["value"] = "2016-08-30 08:10:10"
}
Keystore.set(parameters)
```

For info of the space **User\_Vehicle** is parking at, you can create another parameter 'parkingSpaceRID' to store relationship by role assignment.

```lua
-- Create parameter definition for new parameter.
local param_definitions = {
    ["role_id"] = "vehicle_driver",
    ["body"] = {
        {
            ["name"] = "parkingSpaceRID" -- device RID of parking space
        }
    }
}
User.addRoleParam(param_definitions)
-- User_Vehicle is parking at space 'd2343hbcc1232sweee1'.
local roles_assigned = {
    {
        ["role_id"] = "vehicle_driver",
        ["parameters"] = {
            {
                ["name"] = "parkingSpaceRID",
                ["value"] = "d2343hbcc1232sweee1" -- device RID of parking space
            }
        }
    }
}
User.assignUser({["id"] = 2, ["roles"] = roles_assigned})
```

Because parking space &rsquo;d2343hbcc1232sweee1&rsquo; is occupied, you should also update the number of vacancy of **User\_Parking\_Area**.
```lua
-- Get current number of vacancy of User_Parking_Area
local manager_id = 1
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy"
}
local latest_number = Keystore.get(parameters)

-- Update number of vacancy to latest
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy",
    ["value"] = latest_number - 1 -- User_Vehicle just occupied one parking space.
}
Keystore.set(parameters)
```

Now **User\_Parking\_Area** can access *'GET query/1/parkingVehicle/2/info'* to get parking info of **User\_Vehicle**.

###### <span></span>
```lua
-- Get parking info of User_Vehicle
local driver_id = 2 -- User ID of User_Vehicle
parameters = {
    ["key"] = "Driver_"..driver_id.."_Parking_Start_Time"
}
local parking_start_time = Keystore.get(parameters)

parameters = {
    ["key"] = "Driver_"..driver_id.."_Vehicle_License_Plate_Number"
}
local license_plate_number = Keystore.get(parameters)

-- Find parking space User_Vehicle is parking at

parameters = {
    ["id"] = 2, -- User ID of User_Vehicle
    ["role_id"] = "vehicle_driver",
    ["parameter_name"] = "parkingSpaceRID"
}
local values = User.listUserRoleParamValues(parameters)
local parking_space_rid = values[1]

-- response with parking info
response.message = {
    ["parking_start_time"] = parking_start_time,
    ["license_plate_number"] = license_plate_number,
    ["parking_space_rid"] = parking_space_rid
}
```

When **User\_Vehicle** is going to leave, **User\_Parking\_Area** can charge them according to the parking time.

After **User\_Vehicle** leaves, remove **User\_Vehicle** from the parking list of **User\_Parking\_Area** and update relevant info.

```lua
local roles_removed = {
    ["id"] = 1, -- User ID of User_Parking_Area
    ["role_id"] = "parking_area_manager",
    ["parameter_name"] = "vehicleID",
    ["parameter_value"] = 2 -- User ID of User_Vehicle
}
User.deassignUserParam(roles_removed)

-- Also remove relationship between User_Vehicle and parking space
local roles_removed = {
    ["id"] = 2, -- User ID of User_Vehicle
    ["role_id"] = "vehicle_driver",
    ["parameter_name"] = "parkingSpaceRID",
    ["parameter_value"] = "d2343hbcc1232sweee1"
}
User.deassignUserParam(roles_removed)

-- Update parking info of User_Vehicle
local driver_id = 2 -- User ID of User_Vehicle
parameters = {
    ["key"] = "Driver_"..driver_id.."_Parking_Start_Time",
    ["value"] = "0000-00-00 00:00:00"
}
Keystore.set(parameters)

-- Update number of vacancy of User_Parking_Area
local manager_id = 1
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy"
}
local latest_number = Keystore.get(parameters)

parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy",
    ["value"] = latest_number + 1 -- User_Vehicle just left.
}
Keystore.set(parameters)
```

**User\_Parking\_Area** cannot access *'GET query/1/parkingVehicle/2/info'* any longer since **User\_Vehicle** is not in their parking list.

```lua
-- Background process of checking if User_Parking_Area can access 'GET query/1/parkingVehicle/2/info'.

local check_permission = {
    ["id"] = 1, -- User ID of User_Parking_Area
    ["perm_id"] = "GET/query/{parkingAreaID}/parkingVehicle/{vehicleID}/info", -- {method}/{end_point}
    ["parameters"] = {
        "parkingAreaID::1", -- Specifies value 1 for parameter 'parkingAreaID' in endpoint
        "vehicleID::2" -- Specifies value 2 for parameter 'vehicleID' in endpoint
    }
}
local result = User.hasUserPerm(check_permission)
```

Because currently **User\_Parking\_Area** does not have parameter &rsquo;vehicleID&rsquo; = 2 in role &rsquo;parking_area_manager&rsquo;, it is expected to get result.status == 403.

# <span id="head_reference">Reference for Example</span>
* RBAC
   * User
      * [User.createUser()](#eg_createUser)
      * [User.activateUser()](#eg_activateUser)
   * Role
      * [User.createRole()](#eg_createRole)
      * [User.addRoleParam()](#eg_caddRoleParam)
   * Endpoint
      * [User.createPermission()](#eg_createPermission)
   * Role-Endpoint Relation
      * [User.addRolePerm()](#eg_addRolePerm)
   * Role-User Relation
      * [User.assignUser()](#eg_assignUser)
      * [User.deassignUserParam()](#eg_deassignUserParam)
      * [User.hasUserPerm()](#eg_hasUserPerm)
      * [User.listUserRoleParamValues()](#eg_listUserRoleParamValues)

* User Storage
   * [User.createUserData()](#eg_createUserData)
   * [User.updateUserData()](#eg_updateUserData)
   * [User.getUserData()](#eg_getUserData)