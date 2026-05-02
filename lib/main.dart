import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// main app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

// ================= MAIN =================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  // list of food items
  final List<Map<String, String>> foodList = [
    {
      "name": "Classic Beef Burger",
      "price": "8.99",
      "image":
          "https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg"
    },
    {
      "name": "Double Cheese",
      "price": "11.50",
      "image":
          "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg"
    },
    {
      "name": "Spicy Burger",
      "price": "9.50",
      "image":
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500"
    },
    {
      "name": "Mushroom Burger",
      "price": "10.20",
      "image":
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500"
    },
  ];

  @override
  Widget build(BuildContext context) {

    // screens list
    final pages = [
      HomeScreen(foods: foodList),
      FavoritesScreen(foods: foodList),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.orange,

        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Fav"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ================= HOME =================
class HomeScreen extends StatelessWidget {

  final List<Map<String, String>> foods;

  const HomeScreen({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mansoura",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            Text("Order Your Food",
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
      ),

      body: Column(
        children: [

          // search field
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                categoryItem("Burgers"),
                categoryItem("Pizza"),
                categoryItem("Drinks"),
                categoryItem("Snacks"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),

              itemCount: foods.length,

              itemBuilder: (context, i) {
                return buildFoodCard(context, foods[i]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // simple chip
  Widget categoryItem(String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Chip(
        label: Text(txt),
        backgroundColor: Colors.orange[100],
      ),
    );
  }

  // card widget
  Widget buildFoodCard(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DetailsScreen(food: item),
          ),
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15)),

                  child: Image.network(
                    item["image"]!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const Positioned(
                  right: 5,
                  top: 5,
                  child: Icon(Icons.favorite_border,
                      color: Colors.red),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["name"]!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 5),

                  Text("\$${item["price"]!}",
                      style:
                          const TextStyle(color: Colors.orange)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= DETAILS =================
class DetailsScreen extends StatelessWidget {

  final Map<String, String> food;

  const DetailsScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [

          Stack(
            children: [

              Image.network(
                food["image"]!,
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Positioned(
                top: 40,
                left: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.white,

                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              const Positioned(
                top: 40,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite,
                      color: Colors.red),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(25)),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(food["name"]!,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 5),

                  Row(
                    children: const [
                      Icon(Icons.star,
                          color: Colors.orange, size: 18),
                      Text(" 4.8 (41 Reviews)"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text("\$${food["price"]!}",
                      style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 18)),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: const [
                      InfoBox(title: "Size", value: "Medium"),
                      InfoBox(title: "Energy", value: "554 Kcal"),
                      InfoBox(title: "Delivery", value: "45 min"),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text("About",
                      style: TextStyle(
                          fontWeight: FontWeight.bold)),

                  const Text(
                      "Beef Patty, Cheese, Lettuce, Tomato"),

                  const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize:
                          const Size(double.infinity, 55),
                    ),

                    onPressed: () {},

                    child: const Text("Add to Cart"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InfoBox extends StatelessWidget {

  final String title;
  final String value;

  const InfoBox({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontSize: 12)),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ================= FAVORITES =================
class FavoritesScreen extends StatelessWidget {

  final List<Map<String, String>> foods;

  const FavoritesScreen({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Items"),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: foods.length,

        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.all(10),

            child: Row(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),

                  child: Image.network(
                    foods[i]["image"]!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(foods[i]["name"]!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),

                      Row(
                        children: const [
                          Icon(Icons.star,
                              color: Colors.orange, size: 16),
                          Text(" 4.5"),
                        ],
                      ),

                      Text("\$${foods[i]["price"]!}",
                          style: const TextStyle(
                              color: Colors.orange)),
                    ],
                  ),
                ),

                const Icon(Icons.favorite,
                    color: Colors.red),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ================= PROFILE =================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Column(
        children: [

          const SizedBox(height: 30),

          Stack(
            children: [

              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.orange[100],

                child: const Icon(Icons.person,
                    size: 40, color: Colors.orange),
              ),

              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.edit,
                      size: 15, color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text("Amr M. Elnegry",
              style: TextStyle(fontWeight: FontWeight.bold)),

          const Text("AmrElnegery@gmail.com"),

          const SizedBox(height: 20),

          profileRow(Icons.person, "Edit Profile"),
          profileRow(Icons.location_on, "My Addresses"),
          profileRow(Icons.history, "Order History"),
          profileRow(Icons.favorite, "Favorites"),
          profileRow(Icons.payment, "Payment Methods"),
          profileRow(Icons.notifications, "Notifications"),
          profileRow(Icons.help, "Help & Support"),
          profileRow(Icons.settings, "Settings"),
        ],
      ),
    );
  }

  // simple list item
  Widget profileRow(IconData icon, String txt) {
    return ListTile(
      leading: Icon(icon),
      title: Text(txt),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}