---
layout: page
title: Using Render.com to Deploy a Rails App (Student Guide)
---
<section class="note">
<p>These instructions were compiled from <a href="https://render.com/docs/deploy-rails" target="_blank">Render.com</a>'s existing documentation and resources. You are free to ignore this page and follow directions on Render's website to deploy your application, if you wish. The instructions and links below have been tested as of March 2023.</p>

<p>Turing is not associated or affiliated with Render.com in any way; this page was created as a reference for students to deploy their applications for the first time. 
</p>
</section>

## When should I deploy?
- Deploy to Render (or more generally, the _production_ environment) when your application has reached a new apex in feature availability - in other words, when your `main` branch has been updated to where you are confident that you want it to be available on the internet. 
- When deploying, Render will take ___your remote copy___, you'll be able to select which branch (we recommend `main`), and deploy it to your server. So, follow good git practice and only merge to `main` once your team has decided the code quality is good enough to deploy a new version of the app. 

## Getting Started
1. Create an account on Render, if you haven't already. (You can use GitHub to create an account to make your sign-in even easier.)

2. Locally in the repository you'll be deploying, update the secret key before deploying: 
   1. Delete the existing `config/credentials.yml.enc` file. 
   2. In Terminal in this repository, run `EDITOR="code" bin/rails credentials:edit`.
         - You do need to specify `EDITOR="code"` for it to work unless it already appears in your Terminal's config file, otherwise it may give you errors. 
         - When successful, it will generate 2 files called `credentials.yml.enc` and `master.key`. The `master.key` file will be ignored by git - this is normal, you do not want to share this key with other teammates. 
   3. Commit and push the change that added the new `credentials.yml.enc` file to your remote. 

## Deploying an Existing Rails App

### Create DB Service
1. After you sign in, it will take you to your Dashboard. 
2. Click the button to **Create a New PostgreSQL**. 
   - Give the PostgreSQL service a name (recommend to use the same name as your repo for sanity)
   - You can keep the **Database** and **User** fields blank, they will be randomly generated.
   - **Change the PostgreSQL Version to 14.**
   - Keep the Instance Type set to **Free**, and then click `Create Database`. 
3. Once the database is created, click the `Connect` dropdown on the top-right, and copy the **Internal Database URL**. You'll use this link to connect to the production DB after you create the web service.

### Create Web Service
1. Click the button to Create a New __Web Service__. If you've connected your GitHub account, it will display some of your repositories that you can connect to for this web service. Click `Connect` next to the repo you'd like to deploy. 
1.  Give the service a name (anything, you can use the same name as the repo)
1.  In the **Build Command** step, add `rails db:{migrate,seed}` to the end of the string. 
   - Note that this command will be run each time your application is deployed. As such, your `seeds.rb` file should contain `{Model}.destroy_all` lines at the top so that running the `seed` command in production does not cause duplicate data.
2.  Make sure your **Instance Type** is **Free**, then click the `Create Web Service` button. 
3. On the next screen, you'll need to add 2 Environment Variables, so click **Environment**. 
   1. Key = `DATABASE_URL` , Value = your PostgreSQL service's Internal Database URL, from the previous step. 
   2. Key = `RAILS_MASTER_KEY`, Value = your repo's local `master.key` file. 

If the steps are all working, it will then attempt to build your application and copy it to its container, this will take several minutes. You can watch the service's terminal for updates. If the build is successful, it will display `==> Build successful 🎉` then `==> Deploying...`. When this step finishes, you can click the URL of the application displayed at the top of the page to visit your site. 


<section class="call-to-action">
<br/>
At any time, you can see your applications on Render from a high-level by going to the <a target="_blank" href="https://dashboard.render.com">Render Dashboard</a>. 
<br/><br/>
</section>



## Troubleshooting
- If the build fails, you will see a message like `==> Build failed 😞` in the dashboard terminal, and it will send you an e-mail notification. Any build errors or deployment issues will be listed in the terminal above this message. 
- Note that the Free tier of the Web Service does not allow for SSH console, so you can't use `rails c` on the dashboard unfortunately.  
- You can [read more about the Free tier limitations](https://render.com/docs/free#free-web-services) if you encounter other issues. 
- Further troubleshooting documentation can be found on [Render's website](https://render.com/docs/deploy-rails).  