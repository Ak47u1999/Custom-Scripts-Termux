import sys
import re
from urllib.parse import urlparse, parse_qs

def extract_video_ids(embed_url: str):
    match = re.search(r"embed/([\w-]+)\?playlist=([\w,]*)", embed_url)
    if not match:
        print("Invalid embed URL format.")
        return None
    
    main_video_id = match.group(1)
    playlist_ids = match.group(2).split(",")
    
    # Ensure main video ID is included and remove duplicates while maintaining order
    unique_ids = []
    for vid in [main_video_id] + playlist_ids:
        if vid not in unique_ids:
            unique_ids.append(vid)
    
    return unique_ids

def generate_playlist_url(video_ids):
    base_url = "https://www.youtube.com/watch_videos?video_ids="
    return base_url + ",".join(video_ids)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <YouTube Embed URL>")
        sys.exit(1)
    
    embed_url = sys.argv[1]
    video_ids = extract_video_ids(embed_url)
    
    if video_ids:
        playlist_url = generate_playlist_url(video_ids)
        
        html_content = f"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>YouTube Playlist</title>
        </head>
        <body>
            <h2>Direct YouTube Playlist Link</h2>
            <p><a href="{playlist_url}" target="_blank">{playlist_url}</a></p>
        </body>
        </html>
        """
        
        with open("playlist.html", "w") as file:
            file.write(html_content)
        
        print("HTML file generated: playlist.html")
