import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gaming Gear Shop'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Product 1',
      price: 10,
      imageUrl:
          'https://brain-images-ssl.cdn.dixons.com/0/8/10167480/u_10167480.jpg',
      rating: 4.5,
    ),
    Product(
      name: 'Product 2',
      price: 20,
      imageUrl:
          'https://s24.q4cdn.com/131595232/files/doc_multimedia/2016/08/1/Logitech_G_Pro_Gaming_Mouse_BTY.jpg',
      rating: 3.8,
    ),
    Product(
      name: 'Product 3',
      price: 30,
      imageUrl:
          'https://pcgame.ma/wp-content/uploads/2021/02/Logitech-G403-Hero-Gaming-Mouse-1-1280x1280.jpg',
      rating: 4.2,
    ),
  ];

  final List<String> bannerImages = [
    'https://www.grinpo.com/wp-content/uploads/2021/03/mouse-gaming-banner.jpg',
    'https://azcd.harveynorman.com.au/media/wysiwyg/product/featured/LogitechG203Mouse/g203-gaming-mouse-banner.png',
    'https://wallpaperaccess.com/full/4014390.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length + 2, // Add 2 for the greeting and banner
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Hello, John Doe!', // Modify the greeting message as needed
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        if (index == 1) {
          return Container(
            height: 150, // Adjust the height of the banner
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  10), // Adjust the border radius as needed
              child: CarouselSlider(
                items: bannerImages.map((imageUrl) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover, // Make the image fit the container
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                ),
              ),
            ),
          );
        }

        final product = products[index - 2];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(product: product),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Image.network(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(product.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: \$${product.price}'),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text(' ${product.rating.toStringAsFixed(1)}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final double rating;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });
}

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            product.imageUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Product Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Name: ${product.name}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Price: \$${product.price}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Rating: ${product.rating.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        CircleAvatar(
          radius: 70,
          backgroundImage: NetworkImage(
              'https://i.pinimg.com/originals/34/31/63/3431632de6124926dcfa7bb4159613af.jpg'),
        ),
        SizedBox(height: 20),
        Text(
          'John Doe',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              MenuBox(
                child: MenuItem(
                  icon: Icons.settings,
                  text: 'Settings',
                  onPressed: () {
                    // Add your functionality here
                  },
                ),
              ),
              SizedBox(height: 20),
              MenuBox(
                child: MenuItem(
                  icon: Icons.email,
                  text: 'Email',
                  onPressed: () {
                    // Add your functionality here
                  },
                ),
              ),
              SizedBox(height: 20),
              MenuBox(
                child: MenuItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onPressed: () {
                    // Add your functionality here
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const MenuItem({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 30),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuBox extends StatelessWidget {
  final Widget child;

  const MenuBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
