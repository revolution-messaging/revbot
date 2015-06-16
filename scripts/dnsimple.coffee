# Description:
#   Domain availability via DNSimple.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_DNSIMPLE_USERNAME
#   HUBOT_DNSIMPLE_API_TOKEN
#
# Commands:
#   hubot check domain <domainname> - returns whether a domain is available
#
# Author:
#   jonmagic

dnsimpleToken = process.env.HUBOT_DNSIMPLE_USERNAME + ':' + process.env.HUBOT_DNSIMPLE_API_TOKEN

module.exports = (robot) ->
  robot.respond /check domain (.*)/i, (msg) ->
    domain = msg.match[1]
    msg.http("https://api.dnsimple.com/v1/domains/#{domain}/check")
      .headers("X-DNSimple-Token": dnsimpleToken, Accept: "application/json", "User-Agent": "hubot-dnsimple")
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            msg.send "Sorry, #{domain} is not available."
          when 404
            msg.send "Woohoo! #{domain} can be registered today!"
          when 401
            msg.send "You need to authenticate by setting the HUBOT_DNSIMPLE_USERNAME & HUBOT_DNSIMPLE_API_TOKEN environment variables"
          else
            msg.send "Unable to process your request and we're not sure why :("
