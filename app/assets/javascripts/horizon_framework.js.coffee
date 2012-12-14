SublimeVideo.horizonFrameworkReady = ->
  SublimeVideo.setupHorizonFrameworkSublime()

SublimeVideo.setupHorizonFrameworkSublime = ->
  sublime.ready ->
    if ($videoTrigger = $('#video_horizon_trigger')).exists()
      $videoTrigger.on 'click', (event) ->
        event.preventDefault()
        $videoTrigger.hide()
        sublime.prepare 'video_horizon', (player) ->
          player.on 'action:showcases', ->
            go = -> document.location.href = '/tailor-made-players'
            if player.isFullscreen() then player.exitFullscreen(go) else go()
          player.on 'action:teamup', ->
            go = -> document.location.href = '/tailor-made-players-requests/new'
            if player.isFullscreen() then player.exitFullscreen(go) else go()
          player.on 'action:signup', ->
            go = -> SublimeVideo.UI.Utils.openAccountPopup('signup')
            if player.isFullscreen() then player.exitFullscreen(go) else go()
          player.play()