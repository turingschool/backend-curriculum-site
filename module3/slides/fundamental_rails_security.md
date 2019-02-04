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

# Warmup

* Follow lesson instructions.

---

# Share

---

# Attempt an Exploit

In your groups follow the lesson instructions.

---

# Prevention

* `gem install brakeman`
* Will help audit your application.

---

# Things to Remember

* Be suspicious of any class method in a controller.
* Scope all queries to a trusted object, like the current user.
* Be careful with your order of operations, don’t change any data until you've found a specified record.


