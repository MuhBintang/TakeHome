import 'package:flutter/material.dart';
import 'package:takehome/models/database_instance.dart';
import 'package:takehome/models/model_all.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Result> favouriteCharacters = [];
  DatabaseInstance dbInstance = DatabaseInstance();

  @override
  void initState() {
    super.initState();
    _fetchFavouriteCharacters();
  }

  Future<void> _fetchFavouriteCharacters() async {
    List<Result> favourites = await dbInstance.getFavouriteCharacters();
    setState(() {
      favouriteCharacters = favourites;
    });
  }

  Future<void> _deleteCharacter(Result character) async {
    await dbInstance.deleteFavourite(character.id);
    await _fetchFavouriteCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Favourite Characters', style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
      body: favouriteCharacters.isEmpty
          ? Center(
              child: Text(
                'No Character Has Been Added',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
              itemCount: favouriteCharacters.length,
              itemBuilder: (context, index) {
                Result character = favouriteCharacters[index];
                return CharacterTile(
                  character: character,
                  onDelete: _deleteCharacter,
                );
              },
            ),
    );
  }
}

class CharacterTile extends StatelessWidget {
  final Result character;
  final void Function(Result) onDelete;

  const CharacterTile({
    Key? key,
    required this.character,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF282D36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        backgroundColor: Color(0xFF282D36),
        collapsedBackgroundColor: Color(0xFF282D36),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.image),
        ),
        title: Text(
          character.name,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  'Species:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${character.species}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Gender:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${character.gender}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Origin:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${character.origin.name}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Location:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${character.location.name}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Status:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${character.status}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      onDelete(character); // Panggil fungsi onDelete saat tombol ditekan
                    },
                    icon: Icon(Icons.favorite),
                    label: Text('Remove from Favorites'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
