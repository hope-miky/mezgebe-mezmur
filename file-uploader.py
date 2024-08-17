import json
import firebase_admin
from firebase_admin import credentials, firestore

# Path to your Firebase Admin SDK JSON file
cred = credentials.Certificate('mezgebemezmur-dev-firebase-adminsdk-fbe0d-6061cc2f1f.json')
firebase_admin.initialize_app(cred)

# Initialize Firestore DB
db = firestore.client()

# Function to upload song data to Firestore
def upload_songs_to_firestore(json_file_path):
    # Load JSON data
    with open(json_file_path, 'r', encoding='utf-8') as f:
        songs = json.load(f)
    
    # Reference to the Firestore collection
    collection_ref = db.collection('mezmurs')
    
    for song in songs:
        if int(song['id']) > 124:
            doc_ref = collection_ref.document(str(song['id']))
            # Prepare data
            data = {
                'id': int(song['id']),
                'tags': song['tags'],
                'title': song['title'],
                'artist': song['artist'],
                'lyrics': song['lyrics']
            }
            # Upload data
            doc_ref.set(data)
            print(f"Uploaded song with ID: {song['id']}")

# Path to your JSON file
json_file_path = 'mezmurs_lyrics.json'
upload_songs_to_firestore(json_file_path)
