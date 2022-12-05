---
layout: page
title: Using Fly.io to Deploy a Rails App (Student Guide)
---
<section class="note">
<p>These instructions were compiled from <a href="https://fly.io" target="_blank">Fly.io</a>'s existing documentation and resources. You are free to ignore this page and follow directions on Fly.io's website to deploy your application, if you wish. The instructions and links below have been tested as of December 2022.</p>

<p>Turing is not associated or affiliated with Fly.io in any way; this page was created as a reference for students to deploy their applications for the first time. 
</p>
</section>

## When should I deploy?
- Deploy to Fly (or more generally, the _production_ environment) when your application has reached a new apex in feature availability - in other words, when your `main` branch has been updated to where you are confident that you want it to be available on the internet. 
- When deploying, Fly will take ___your local copy___, no matter what branch it is on, and deploy it to your server. This also means it will take all local changes, no matter if it is committed to Git or not, and deploy them to your server. So, follow good git practice and only deploy from `main`, once your team has decided it is time to deploy a new version. 

## Getting Started
1. Install [Fly's command line tools](https://fly.io/docs/hands-on/install-flyctl)
- `brew install flyctl`
- This may take a few minutes, please be patient. 

1. Log into Fly from your Terminal ([Documentation link](https://fly.io/docs/getting-started/log-in-to-fly))
- `flyctl auth login`
- This will open your browser and prompt you to log in. 
- If you haven't made an account yet, click the link to make one. (You can also use GitHub to create an account, in order to sign in even easier.)
- *NOTE*: It will look like you have to enter a credit card number to complete registration. There is a small link below the form that says ___"Try Fly.io for Free -->"___ Click that link to proceed with the free plan. 
      - If for some reason you must enter a credit card to complete registration, please reach out to your instructors for assistance. 


## Deploying an Existing Rails App

1. In Terminal, navigate to the app that you want to launch, in its root folder (e.g. `/turing/2module/projects/relational_rails`). 

1. Follow Fly's instructions to [launch an existing Rails app](https://fly.io/docs/rails/getting-started/existing). 
   - `fly launch`
      - It will "scan" your code, detect a Rails app, and ask you some questions. 
   - Leave "App Name" blank, or type one in. The name should be unique to your account. 
   - *Important:* When asked, choose the __default region__ by pressing `Enter`. 
      - Note: Some users have had weird errors and issues when they choose a non-default region. In this scenario, it may be easier to delete the deployment on your [Fly.io Dashboard](https://fly.io/dashboard) than to fiddle around with it for too long. 
   - When asked to select a configuration, select `Development` (this is the first option). 
   - When asked, "`Would you like to set up a Postgresql database now? y/n"` enter `Y` for yes. 
   - Copy to a file or screenshot the given postgresql Username, Password, Hostname, and Ports data, as you may need this later. Save this to your desktop for safe keeping. You should _not_ commit this to your repository. 
   - When asked, "`Would you like to set up an Upstash Redis database now? y/n"` enter `n` for no. 

1. When the above steps are completed, double-check that you are on a local branch that you want to deploy (usually this is the `main` branch). Then, run `fly deploy` to deploy a copy of the files/folders in this branch to the newly-created server. At the end of this process, Fly will automatically run your `db` setup tasks like create, migrate, and seed. 

1. If your deployment is successful, it will display `"Monitoring deployment..." ` and `---> v0 deployed successfully.`. This `v0` number will increment with each subsquent deployment. Run `fly open` to open your deployed application in your browser. 

<section class="call-to-action">
<br/>
At any time, you can see your applications on Fly from a high-level by going to the <a target="_blank" href="https://fly.io/dashboard">Fly Dashboard</a>. 
<br/><br/>
</section>



## Troubleshooting
- If you visit your app in the browser and see some generic errors, those messages will probably be vague and unhelpful. This is because you're looking at the production environment, which is meant to be seen by users and not developers. To see helpful debugging information, run `fly logs` from your local Terminal in order to see logs of your deployments. 
- To open a rails console on your server, run `fly ssh console -C "/app/bin/rails console"`. 
   - Be careful of using this, as you are accessing the Rails console directly in production! Also, this may incur more usage of the application which can run up your usage on Fly's service. If you've provided a credit card number, it may end up charging you. 

- Problem: an error message in deployment that ends with: 
```
ERROR: [stage-3 7/7] RUN bin/rails fly:build … rails aborted! ExecJS: RuntimeUnavailable: Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes.
```
   - Solution: Open the `Dockerfile` in the root of the project. Around line 76, find `ARG DEPLOY_PACKAGES`. At the end of this string value, add `nodejs`. It should now look like this: 
   ```ruby
   ARG DEPLOY_PACKAGES="postgresql-client file vim curl gzip libsqlite3-0 nodejs"
   ```
   Finally, run `fly deploy` again. 

- Further troubleshooting documentation can be found on [Fly's website](https://fly.io/docs/rails/getting-started/existing/#troubleshooting-your-initial-deployment).  