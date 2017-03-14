# vagrant-dev-env-rails

Vagrant file to create an Ubuntu 14.04 VM, and then use a shell script to provision it with Git, Ruby 2.4, Rails 5, Postgres and Heroku CLI.

Setup in the provisioning shell script is based on:
* https://gorails.com/setup/ubuntu/14.04 (Ruby, Rails, Posgres)
* https://devcenter.heroku.com/articles/heroku-cli (Heroku CLI)

## Usage
You must have Vagrant installed - if you don't, see the [Vagrant Getting Started guide](https://www.vagrantup.com/docs/getting-started/).

1. Checkout this repo: `$ git clone https://github.com/asibs/vagrant-dev-env-rails.git my-rails-env`
2. Change directory into the repo: `$ cd my-rails-env`
3. Download, boot, and provision your VM: `$ vagrant up`
    * The first time you do this it'll take a while to provision your VM, ~10 mins
4. SSH onto the new VM: `$ vagrant ssh`

That's it!

## Post setup steps
A few things you may want to do post setup...

### Update git settings for the repo
```
$ git config --local core.autocrlf true
$ git config --local core.filemode false
```

If you intend to checkout or create any repositories on the VMs vagrant share `/vagrant/` (which is accessible to both your host machine, and the guest VM you've just created), it's probably worth doing this. Not doing so can result in various systems thinking there are changes in your git repos even when there are none according to `git status` (certainly occurs with a Windows 10 host using the [Atom editor](https://atom.io/))

### Create a postgres user and database for your rails app
```
$ sudo su - postgres
$ psql
# CREATE USER myapp ENCRYPTED PASSWORD 'mypassword';
# CREATE DATABASE myappdb WITH OWNER myapp;
# \quit
```

After this, you can configure your app appropriately so it can connect to the postgres db, and you can manually connect to the DB as the application user with the following command:
```
psql  --host=localhost  --username=myapp  --dbname=myappdb
```

## Notes

The `.gitignore` for this project purposefully ignores everything aside from specific files / folders. This is so you can more safely checkout repos onto your Vagrant VM.
