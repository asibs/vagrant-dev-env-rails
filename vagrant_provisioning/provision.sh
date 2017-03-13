#!/bin/bash
#
# Steps 1-6 install rails, following instructions as per go rails: https://gorails.com/setup/ubuntu/14.04
# (slightly altered from the original instructions so that everything runs OK in a shell script...)
#
# Step 7 installs Heroku CLI, following instructions as per the Heroku Dev Center: https://devcenter.heroku.com/articles/heroku-cli

su vagrant << EOF

    echo "*** STEP 1 - Installing core dependencies using apt-get ***"
    sudo apt-get update
    sudo apt-get install -y  git  git-core  curl  zlib1g-dev  build-essential  libssl-dev  \
                             libreadline-dev  libyaml-dev  libsqlite3-dev  sqlite3  libxml2-dev  \
                             libxslt1-dev  libcurl4-openssl-dev  python-software-properties  \
                             libffi-dev  nodejs


    echo "*** STEP 2 - Downloading rbenv from github, and adding it to PATH ***"
    cd
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="\$HOME/.rbenv/bin:\$PATH"' >> ~/.bashrc
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="\$HOME/.rbenv/plugins/ruby-build/bin:\$PATH"' >> ~/.bashrc
    echo 'eval "\$(rbenv init -)"' >> ~/.bashrc
    PS1='$ '  # Trick .bashrc into thinking we're running interactively, which allows us to 'source ~/.bashrc'
    source ~/.bashrc


    echo "*** STEP 3 - Installing ruby 2.4.0 using rbenv ***"
    rbenv install 2.4.0
    rbenv global 2.4.0

    gem install bundler
    rbenv rehash


    echo "*** STEP 4 - Installing nodejs using apt-get ***"
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    sudo apt-get install -y nodejs


    echo "*** STEP 5 - Installing rails 5.0.1 using rubygems ***"
    gem install rails -v 5.0.1
    rbenv rehash


    echo "*** STEP 6 - Installing postgresql using apt-get ***"
    sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y  postgresql-common  postgresql-9.5  libpq-dev


    echo "*** STEP 7 - Installing heroku cli tools using apt-get ***"
    # Instructions here don't work (apt-get gives 403):  https://devcenter.heroku.com/articles/heroku-cli#download-and-install
    # Fall back to instructions here instead: https://devcenter.heroku.com/articles/heroku-cli#legacy-ruby-cli
    #sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
    #curl -sL https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
    #sudo apt-get update
    #sudo apt-get install heroku

    wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
    # Call Heroku to force it to update itself...
    heroku --version

EOF
