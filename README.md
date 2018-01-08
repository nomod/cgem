# Chat
Short description and motivation.

## Usage
In application.js:

    //= require chat/application

In application.css:
    
    *= require chat/application

In Connection:

    identified_by :current_user_chat

    def connect
      self.current_user_chat = find_verified_user
    end

    protected

    def find_verified_user
      remember_token = Digest::SHA1.hexdigest(cookies[:chat_token].to_s)
      if @current_user_chat.nil?
        @current_user_chat = Chat::User.find_by(chat_token: remember_token)
      else
        @current_user_chat
      end
    end

In ApplicationController:

      helper Chat::Engine.helpers
      before_action :current_user_chat, :check_session, :user_activity
      after_action :online_info
    
In routes:
    
    mount Chat::Engine, at: '/chat'
    
In application.html.slim:
    
    = render 'chat/basic/operators'

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'chat', git: 'https://github.com/nomod/cgem'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install chat
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
