
# TalkingBenTheDog

Telegram bot that answers questions with multiple options


## Installation

Install project with git

```bash
  git clone https://gitlab.com/xar4a/TalkingBenTheDog-telegram-bot.git
  cd TalkingBenTheDog-telegram-bot
```
    
## Change the configs

Set the t.me/botfather token

```bash
  nano api.key
```
(optional) Change the text in config.ini
```bash
  nano config.ini
```
## Deployment

To deploy this project:

Install dependencies

```bash
  nimble install telebot
```

Start deploy

```bash
  nim compile -d:release -d:ssl main.nim
```


## Run tgbot



Start the server

```bash
  chmod +x main
  ./main
```

