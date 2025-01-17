# SPDX-License-Identifier: AGPL-3.0-only
import options
import karax/[karaxdsl, vdom]
from jester import Request

import ".."/[types, formatters]
import general, tweet

const doctype = "<!DOCTYPE html>\n"

proc renderVideoEmbed*(tweet: Tweet; cfg: Config; req: Request; color=""): string =
  let thumb = get(tweet.video).thumb
  let vidUrl = getVideoEmbed(cfg, tweet.id)
  let prefs = Prefs(hlsPlayback: true, mp4Playback: true)
  let node = buildHtml(html(lang="en")):
    renderHead(prefs, cfg, req, video=vidUrl, images=(@[thumb]), color=color)

    body:
      tdiv(class="embed-video"):
        renderVideo(get(tweet.video), prefs, "")

  result = doctype & $node
