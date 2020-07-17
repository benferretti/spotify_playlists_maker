require 'dotenv'
require 'rspotify'
require 'pry'

Dotenv.load('.env')

def login_spotify
	RSpotify.authenticate(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
end

def search_playlists(search_parameter)
	login_spotify
	array_of_tracks = Array.new
	playlists = RSpotify::Playlist.search(search_parameter, limit: 50)
	playlists.each do |playlist|
		playlist.tracks.each do |track|
			array_of_tracks << track.uri
		end
	end
	counts = Hash.new(0)
	array_of_tracks.each { |track| counts[track] += 1 }
	counts.each {|id, k| (k < 3) ? counts.delete(id) : nil} 
	playlist = RSpotify::Playlist.find('GamingTHP', '7Me6bo6OOCqzJQz13UiCFd')
	counts.each do |track, k|
		track = track[14..-1]
		a = ('curl -X "POST" "https://api.spotify.com/v1/playlists/7Me6bo6OOCqzJQz13UiCFd/tracks?uris=spotify%3Atrack%3A' + track + '" -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer BQA-VKYK5szXSxQ-_s-DaLqm5O2KIq4uK974qKcmee3jfWP3xCMbED5cXSS7Zl3eG28lqg3FRDNLcJP6htXm4IfUOPGZ-XFQrisv5b2Vv_nKaItISgIwbU25FWFkUID9pAIUnv3Wy79CNTEVPq9KgknypkmmpEmAoJvNXz6T4MbAW2FSP_RVIHF1WqQYR7tFBRK8qqvkK_u7PshDDy0j_A"')
		system(a)
	end
end

search_playlists('Chill')


#7Me6bo6OOCqzJQz13UiCFd