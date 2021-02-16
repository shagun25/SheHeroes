<h1 align="center"><img width="464" alt="Screen Shot 2020-11-21 at 10 28 41 PM" src="https://user-images.githubusercontent.com/56549294/99883790-a6f45100-2c4f-11eb-925b-7c155f3772d1.png">
<h1 align="center">SheHeroes - Women Safety App</h1>

<!--[![All Contributors](https://img.shields.io/badge/all_contributors-04-orange.svg?style=flat-square)](#contributors-)-->

[![forthebadge](https://forthebadge.com/images/badges/built-by-developers.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-swag.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/for-you.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/open-source.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/check-it-out.svg)](https://forthebadge.com)


## :label: Inspiration
Considering the safety and security of women in India in the recent times, We wanted to give a try from our end to address the issue in a simpler and safer way.

Looking at the recent trends and the most powerful weapon with the humanity - technology, we planned to use the same to give access to women in serious or dangerous situations to address the issue in a fast and easier way to ensure their security.


 [Video Description](https://drive.google.com/file/d/1IqV4nTDAD8PjvhigO-51IQvEWMNxjqUw)
 

## :label: Tech Stack
   * Flutter
   * Firestore
   * Google Map Api
   * Crimometer Api 
   
## :label: Features

  #### Main Features
  
   :point_right: Map - To track the current location of the user, guiding for safe routes and crime prone areas.<br/>
   :point_right: Voice Assistant - executes features on voice commands<br/>
     
  #### Additional Features
  
   :point_right: SOS - SOS call and SOS messages to user provided contacts<br/>
   :point_right: Shake - Detects the frequency of shakes and after a certain frequency sends help message with user location to provided contacts<br/>
   :point_right: Camera - To capture image or and record video and save it to the local storage <br/>
   :point_right: Police stations - Locates all the nearest police stations<br/>
   :point_right: Police siren - Rings the police siren<br/>
   :point_right: Taxi - One touch ola cab facility to books cabs for user<br/>
   :point_right: News - To guide the users about self defense techniques<br/>
## ⭐ How to get started?
[![forthebadge](https://forthebadge.com/images/badges/not-a-bug-a-feature.svg)](https://forthebadge.com) <br>
You can refer to the following articles on the basics of Git and Github and also contact the Project Mentors, in case you are stuck:

- [Watch this video to get started, if you have no clue about open source](https://youtu.be/SL5KKdmvJ1U)
- [Forking a Repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)
- [Cloning a Repo](https://help.github.com/en/desktop/contributing-to-projects/creating-a-pull-request)
- [How to create a Pull Request](https://opensource.com/article/19/7/create-pull-request-github)
- [Getting started with Git and GitHub](https://towardsdatascience.com/getting-started-with-git-and-github-6fcd0f2d4ac6)

<br>

## ⭐ Steps to follow :scroll:

<br>


### 1️⃣ Fork it :fork_and_knife:

You can get your own fork/copy of [SheHeroes](https://github.com/shagun25/SheHeroes) by using the <kbd><b>Fork</b></kbd> button.

<br>


### 2️⃣ Clone it :busts_in_silhouette:

You need to clone (download) it to local machine using

```sh
$ git clone https://github.com/Your_Username/SheHeroes.git
```

> This makes a local copy of repository in your machine.

Once you have cloned the `SheHeroes` repository in Github, move to that folder first using change directory command on linux and Mac.

```sh
# This will change directory to a folder SheHeroes
$ cd SheHeroes
```

Move to this folder for all other commands.

<br>



### 3️⃣ Set it up :arrow_up:

Run the following commands to see that *your local copy* has a reference to *your forked remote repository* in Github :octocat:

```sh
$ git remote -v
origin  https://github.com/Your_Username/SheHeroes.git (fetch)
origin  https://github.com/Your_Username/SheHeroes.git (push)
```
Now, lets add a reference to the original [SheHeroes](https://github.com/shagun25/SheHeroes) repository using

```sh
$ git remote add upstream https://github.com/shagun25/SheHeroes.git
```

> This adds a new remote named ***upstream***.

See the changes using

```sh
$ git remote -v
origin    https://github.com/Your_Username/SheHeroes.git (fetch)
origin    https://github.com/Your_Username/SheHeroes.git (push)
upstream  https://github.com/shagun25/SheHeroes.git (fetch)
upstream  https://github.com/shagun25/SheHeroes.git (push)
```

<br>



### 4️⃣ Sync it :recycle:

Always keep your local copy of repository updated with the original repository.
Before making any changes and/or in an appropriate interval, run the following commands *carefully* to update your local repository.

```sh
# Fetch all remote repositories and delete any deleted remote branches
$ git fetch --all --prune

# Switch to `master` branch
$ git checkout master

# Reset local `master` branch to match `upstream` repository's `master` branch
$ git reset --hard upstream/master

# Push changes to your forked `SheHeroes` repo
$ git push origin master
```

<br>



### 5️⃣ Ready Steady Go... :turtle: :rabbit2:

Once you have completed these steps, you are ready to start contributing by checking our `Help Wanted` Issues and creating [pull requests](https:/shagun25/SheHeroes/github.com//pulls).

<br>

### 6️⃣ Create a new branch :bangbang:

Whenever you are going to make contribution. Please create seperate branch using command and keep your `master` branch clean (i.e. synced with remote branch).

```sh
# It will create a new branch with name Branch_Name and switch to branch Folder_Name
$ git checkout -b Folder_Name
```

Create a seperate branch for contibution and try to use same name of branch as of folder.

To switch to desired branch

```sh
# To switch from one folder to other
$ git checkout Folder_Name
```

To add the changes to the branch. Use

```sh
# To add all files to branch Folder_Name
$ git add .
```

Type in a message relevant for the code reveiwer using

```sh
# This message get associated with all files you have changed
$ git commit -m 'relevant message'
```

<br>


### 8️⃣ Share your work :star_struck:

Now, Push your awesome work to your remote repository using

```sh
# To push your work to your remote repository
$ git push -u origin Folder_Name
```

Then, go to your repository in browser and click on `compare and pull requests`.
Then add a title and description to your pull request that explains your precious effort.

<br>

## :label: Developed By
   - [Shagun Goyal](https://github.com/shagun25) 
   - [Charu Sachdeva](https://github.com/Charu271)
   - [Arshdeep Singh](https://github.com/ArshdeepSahni)
   - [Ayushi Sharma](https://github.com/ayushi0014)
# Note:
Look into [Contributing Guidelines](https://github.com/kavania2002/MobiMart/blob/main/.github/contributing.md) for contributing to this repository.
- Don't make PR directly, make issues first, once you are assigned, start working and then create a PR
-**Kindly join the Project Channel for discussions related to this project from** [here](https://discord.gg/rSAVU6XA)
# We are a part of Cross WinterOfCode 21'

![](cross.png)
## :label: ScreenShots

|||
|---|---|
|<h3 align="center">Authentication</h3><img width="1440" alt="Screen Shot 2020-11-21 at 10 00 58 PM" src="https://user-images.githubusercontent.com/56549294/99883797-aa87d800-2c4f-11eb-9bdf-fe080280d319.png">|<h3 align="center">Voice Assistant</h3><img width="1440" alt="Screen Shot 2020-11-21 at 10 00 45 PM" src="https://user-images.githubusercontent.com/56549294/99883798-abb90500-2c4f-11eb-881a-af84d9c75f1e.png">|
|<h3 align="center">Emergency Dashboard</h3><img width="1440" alt="Screen Shot 2020-11-21 at 10 00 32 PM" src="https://user-images.githubusercontent.com/56549294/99883799-ac519b80-2c4f-11eb-8521-ebd283ce16a0.png">|<h3 align="center">Safe Dashboard</h3><img width="1440" alt="Screen Shot 2020-11-21 at 10 00 20 PM" src="https://user-images.githubusercontent.com/56549294/99883801-acea3200-2c4f-11eb-96b1-aea436439ede.png">|
|<h3 align="center">Switcher</h3><img width="1440" alt="Screen Shot 2020-11-21 at 10 00 06 PM" src="https://user-images.githubusercontent.com/56549294/99883803-ae1b5f00-2c4f-11eb-8a8e-85493ebd6aaf.png">||

