import mc
from urllib import quote_plus, urlencode

stream_url = '__STREAM_URL__'

playlist_url = "playlist://%s?live=1&quality=A" % quote_plus(stream_url)

item = mc.ListItem(mc.ListItem.MEDIA_VIDEO_EPISODE)
item.SetPath(playlist_url)
item.SetLabel('BBC News')
item.SetContentType = 'application/vnd.apple.mpegurl'
mc.GetPlayer().Play(item)
