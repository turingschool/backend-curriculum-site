# Fundamental Rails Security

---

# Obscurity is not security

* Assume all source code could be public.
    * You or a contributor could lose a laptop.
    * Your private repo could be hosted by a service that is hacked.
    * You could upload on an unsecured network.
* Assume nefarious actors know Rails conventions.

---

# Security is Hard

* We're going to go over a few vulnerabilities, and a few fixes.
* In isolation, these fixes won't necessarily prevent your app from being hacked.
* Still, fix all the things you can.

---

# Privilege Escalation

---

# Definition

* Exploiting a bug to gain access to a resource normally protected.

Two Types

* Horizontal: Viewing someone else's info.
* Vertical: Accessing administrative controls.

---

# Potential Vulnerability

Keep an eye out for class methods.

```ruby
def update
  @order = Order.find(params[:id])
  if @order.update(params[:order])
    flash[:success] = "Order Updated"
    redirect_to order
  else
    flash[:failure] = "Validation Failed"
    render :edit
  end
end
```

---

# Controller Fix

Scope class methods to our `current_user`.

```ruby
def update
  @order = current_user.orders.find(params[:id])
  if @order.update(params[:order])
    flash[:success] = "Order Updated"
    redirect_to order
  else
    flash[:failure] = "Validation Failed"
    render :edit
  end
end
```

---

# Live Example

* Oregon Sale
* Log in as `jeff@turing.io`, password: `password`
* In Postman:
    * Select PUT request to `localhost:3000/orders/1`
    * In the body, select form-data, and add `order[total_cost]` as a key with `0` as the value
    * Submit

---

# Things to Remember

* Be suspicious of any class method in a controller.
* Scope all queries to a trusted object, like the current user.
* Be careful with your order of operations, don’t change any data until you've found a specified record.

---

# Mass Assignment

---

# Definition

* Using a hash to assign values to multiple attributes on a model.
* We do this all the time.

---

# Potential Vulnerability

* Someone puts something into the hash that you don't expect.
* Can edit a form locally on their machine to send additional params.
* Can use something like Postman to send a request.

---

# Live Example

* Rails 3 example.

```ruby
def create
  @user = User.new(params[:user])
  @user.role = :user unless @user.role
  if @user.email
    @user.display_name = @user.full_name unless @user.display_name
  end

  if @user.save
    auto_login(@user)
    redirect_to root_url, :notice => "Signed up"
  else
    render :new
  end
end
```

---

# Live Example Continued

```ruby
# app/models/user.rb
attr_accessible :full_name,
                :display_name,
                :email,
                :password,
                :password_confirmation,
                :role,
                :stripe_customer_token
```

---

# Live Example Continued

* Submit a POST request to `/users` with these keys:
    * `user[full_name]`
    * `user[password]`
    * `user[email]`
    * `user[role]`
* Assign `user[role]` to `admin`.
* Log in as your newly created admin.

---

# Fix

* Rails 3: be conservative with `attr_accessible`
* Rails 4: be conservative with strong params

---

# Workshop

* Clone [Store Engine](git clone https://github.com/turingschool-examples/store_engine.git)
* `bundle`, `rake db:setup`, `rails s`
* Create two users.
* Create various orders with one user.
* Using Postman
    * Can you change an order to a different user?
    * Can you change the status of an order?
    * Can you destroy an order?

---

# Cross Site Scripting

* Inserting scripts into a page to bypass access controls such as the Same-Origin Policy

---

# Same-Origin Policy

* Broadly: a script is limited in what it can do when it tries to access resources on another domain.
* Conversely: a script has more access if it is run from the same domain as the resources it's trying to access.
* If I can make it look like I'm running a script from your domain, I have greater access to your resources.

---

# Types

* Non-persistent: not saved in the database.
* Persistent: Saved in the databaase.
* Both allow an attacker to execute code on your site.

---

# Rails

* Rails made it more difficult to execute persistent attacks.
* HTML stored in variables is rendered as text.
* Unless...

---

# We've Done This

```ruby
flash[:message] =  "Successfully removed #{link_to @item.name, @item} from your cart.".html_safe
```

---

# Vulnerability

* Imagine if we wanted to let users use HTML tags in their comments.
* Imagine if we used `.html_safe` to implement this.
* Imagine if a user realized that meant they could put a script in a comment.

---

# Fix

* Generally don't use `.html_safe` unless you really have to.
* Even then, be sure to sanitize it to remove script tags.

---

# Live Example

* Open app/views/products/_sm_product.html.erb.
* Change line 4 from <%= p.name %> to <%= p.name.html_safe %>
* Run the server and navigate to http://localhost:3000/categories/2

---

# Live Example Continued

* Visit the admin page at /admin
* In the "Product Management" section, go to the "Grub" tab and find "Rations"
* Edit the name to be Rations&lt;script&rt;alert("BOOM!")&lt;/script&rt;
* Visit/refresh http://localhost:3000/categories/1 and you should see a JavaScript alert box saying "BOOM!"

---

# Workshop

* Change a product or user description in the view to accept html_safe or raw.
* Modify an article’s name or description and inject some JavaScript.
    * Can you make the page alert some text when it loads?
    * Can you print some output to the console when the page loads?
    * Can you make the body fade out?
    * Can you make item titles bigger and change their color?
    * Can you make buttons blink?

---

# Recap

* Importance of Rails security
* Privilege Escalation
* Mass Assignment Vulenerabilities
* XSS

---

# One More Thing

* `gem install brakeman`
* Will help audit your application.
