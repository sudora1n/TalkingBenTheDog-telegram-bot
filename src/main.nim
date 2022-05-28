import std/parsecfg
import std/strformat
import std/strutils
import std/random
import telebot
import options
import asyncdispatch
import logging


var L = newConsoleLogger(fmtStr="$levelname, [$time] ")
addHandler(L)

const API_KEY = strip(slurp("api.key"))

let cfg = loadConfig("config.ini")


proc updateHandler(b: Telebot, u: Update): Future[bool] {.async,gcsafe.} = 
    if not u.message.isSome:
      return true
    var respone = u.message.get 
    if respone.text.isSome:
      var rtext = respone.text.get

      var iambenflag = false
      let words = cfg.getSectionValue("ben", "words")
      var lrtext = toLower(rtext)
      for i in words.split(","):
        if lrtext.startsWith(i):
          iambenflag = true
          break

      var endwithflag = false
      let endWith = cfg.getSectionValue("ben", "endWith")
      for i in endWith.split(","):
        if rtext.endsWith(i):
          endwithflag = true
          break

      if iambenflag and endwithflag:
        let answers = cfg.getSectionValue("ben", "answers")
        var answer = sample(answers.split(","))
        doAssert answer in answers
        discard await b.sendMessage(respone.chat.id, fmt"{answer}", parseMode = "markdown", disableNotification = true, replyToMessageId = respone.messageId)
      else: discard


let bot = newTeleBot(API_KEY)
bot.onUpdate(updateHandler)
bot.poll(timeout=300)
