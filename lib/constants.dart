import 'package:sqflite/sqflite.dart';

late Database database;
Map users = {};
Map userToChange = {};
Map itemToOrder = {};
List<Map> allUsers = [];
List<Map> items = [];
List<Map> hotItems = [];
List<Map> coldItems = [];
List<Map> orders = [];
List<Map> usersOrders = [];
Map orderToChange = {};
var itemToChange;

Future<void> getItemsFromDataBase() async {
  items = await database.rawQuery('select * from items').then((value) {
    hotItems = [];
    coldItems = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i]['isHot'] == true || items[i]['isHot'] == 1) {
        hotItems.add(items[i]);
      } else {
        coldItems.add(items[i]);
      }
    }
    return value;
  });
}

Future<void> getUsersFromDataBase() async {
  allUsers = await database.rawQuery('select * from users').then((value) {
    return value;
  });
}

Future<void> getOrdersForOneUser() async {
  orders = await database
      .rawQuery('select * from orders where userId=${users['id']}');
}

Future<void> getAllOrders() async {
  usersOrders = await database.rawQuery('select * from orders');
}

void insertIntoItems(name, description, image, price, isHot) {
  database.insert('items', {
    "name": name,
    "description": description,
    "image": image,
    "price": price,
    "isHot": isHot, // Use the value passed in the function parameter
  }).then((value) {
    print(value);
    print('inserted successfully');
  });
}

Future<bool> registerCustomer({
  required String name,
  required String mail,
  required String password,
  required String phone,
}) async {
  var existingUsers =
      await database.rawQuery('select * from users where email =\'$mail\'');
  if (existingUsers.isEmpty) {
    database.insert('users', {
      'name': name,
      'email': mail,
      'password': password,
      'phone': phone,
      'isAdmin': false,
      'isWorker': false,
      'isCustomer': true
    }).then((value) {

    });
    return true;
  } else {
    return false;
  }
}

Future<bool> addWorker({
  required String name,
  required String mail,
  required String password,
  required String phone,
}) async {
  var existingUsers =
      await database.rawQuery('select * from users where email =\'$mail\'');
  if (existingUsers.isEmpty) {
    database.insert('users', {
      'name': name,
      'email': mail,
      'password': password,
      'phone': phone,
      'isAdmin': false,
      'isWorker': true,
      'isCustomer': false
    }).then((value) {
      // users={'name':name,'email':mail,'password':password,'phone':phone};
    });
    return true;
  } else {
    return false;
  }
}

void createDataBase() {
  openDatabase(
    'pizza.db',
    version: 3,
    onCreate: (db, version) {
      // Separate the CREATE TABLE statements
      db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT,
          phone TEXT,
          password TEXT,
          isAdmin INTEGER,
          isWorker INTEGER,
          isCustomer INTEGER
        );
      ''').catchError((error) {
        print('Error creating users table: $error');
      });
      db.insert('users', {
        'name': 'haytham',
        'email': 'haytham@gmail.com',
        'password': '123456',
        'phone': '123456',
        'isAdmin': true,
        'isWorker': false,
        'isCustomer': false
      });

      db.execute('''
        CREATE TABLE items (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          image TEXT,
          price TEXT,
          isHot BOOLEAN
        );
      ''').catchError((error) {
        print('Error creating items table: $error');
      });

      db.insert('items', {
        'name': 'pizza chicken ranch',
        'description':
        ' Indulge in the savory harmony of grilled chicken, crispy bacon, and creamy ranch dressing atop a bed of melted mozzarella cheese. This pizza masterpiece combines the smoky goodness of seasoned chicken with the rich, tangy notes of ranch, creating a flavor symphony that\'s both satisfying and irresistible. Each bite is a delightful journey through the luscious layers of toppings, making this pizza a perfect choice for those who crave a hearty and ranch-infused culinary experience.',
        'image':
        'https://scontent.fcai19-7.fna.fbcdn.net/v/t1.6435-9/67306918_2427403817315865_6038552928153763840_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=4dc865&_nc_ohc=rSoUuFZ4wl0AX8Scpa0&_nc_ht=scontent.fcai19-7.fna&oh=00_AfBc2uNBI23UWqWFRtojKMVvdPfIbL38xsiylhVHy1UMwA&oe=658F29E7',
        'price': '140',
        'isHot': true
      });

      db.insert('items', {
        'name': 'Margherita Bliss',
        'description':
            'A classic combination of fresh mozzarella, ripe tomatoes, and basil on a thin, crispy crust.',
        'image':
            'https://i0.wp.com/www.blissofcooking.com/wp-content/uploads/2019/09/Pizza-Margherita-Feature-New.jpg?w=720&ssl=1',
        'price': '375',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Pepperoni Passion',
        'description':
            'Generously topped with savory pepperoni slices, gooey melted cheese, and zesty tomato sauce',
        'image':
            'https://pbs.twimg.com/media/CqDOFqjWgAAtYU1?format=jpg&name=small',
        'price': '350',
        'isHot': false
      });
      db.insert('items', {
        'name': 'BBQ Chicken Fiesta',
        'description':
            ' Tender chunks of grilled chicken, red onions, and barbecue sauce, creating a smoky and savory sensation.',
        'image':
            'https://htchickenfiesta.com/cdn/shop/products/257B64AE71C12A25_9b84f41d-e07d-48dc-ab8f-a17928bc1920.jpg?v=1638942788',
        'price': '450',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Hawaiian Luau:',
        'description':
            'A tropical twist with ham, pineapple, and a hint of barbecue sauce for a sweet and savory escape.',
        'image':
            'https://www.jessicagavin.com/wp-content/uploads/2020/07/hawaiian-pizza-16-600x900.jpg',
        'price': '440',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Meat Lovers\' Madness',
        'description':
            ' An indulgent mix of pepperoni, sausage, bacon, and ground beef, delivering a carnivore\'s dream.',
        'image':
            'https://www.jessicagavin.com/wp-content/uploads/2022/02/meat-lovers-pizza-28-600x900.jpg',
        'price': '650',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Pesto Paradise',
        'description':
            'Basil pesto, cherry tomatoes, and feta cheese come together for a burst of Mediterranean flavors.',
        'image':
            'https://s3.eu-central-1.amazonaws.com/qatar-delicious/ItemsImages/ItemImage_13038_(0).jpg',
        'price': '430',
        'isHot': false
      });
      db.insert('items', {
        'name': 'White Garlic Chicken',
        'description':
            ' Creamy garlic sauce, grilled chicken, spinach, and mushrooms unite for a rich and satisfying white pizza.',
        'image':
            'https://i0.wp.com/homanathome.com/wp-content/uploads/2019/02/Pizza-2.jpg?resize=680%2C452&ssl=1',
        'price': '220',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Buffalo Blast',
        'description':
            'Spicy buffalo chicken, blue cheese crumbles, and a drizzle of ranch dressing for a fiery kick.',
        'image':
            'https://kissmysmoke.com/wp-content/uploads/2014/10/Buffalo-Chicken-Pizza-by-Kiss-My-Smoke-2-683x1024.jpg',
        'price': '310',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Mediterranean Marvel',
        'description':
            ' Kalamata olives, artichoke hearts, feta cheese, and sun-dried tomatoes transport your taste buds to the Mediterranean coast.',
        'image':
            'https://scontent.fcai19-7.fna.fbcdn.net/v/t1.6435-9/69572351_10157597369387427_5780865718006317056_n.jpg?stp=dst-jpg_p526x296&_nc_cat=110&ccb=1-7&_nc_sid=7f8c78&_nc_ohc=R1RKALtOfw0AX_BUYrr&_nc_ht=scontent.fcai19-7.fna&oh=00_AfD3jvPnRMKcKbUvGjrJcE7iEDS5RVOk5u5jBtq6XA7nMQ&oe=658C903A',
        'price': '160',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Four Cheese Fantasy',
        'description':
            'A luscious blend of mozzarella, cheddar, parmesan, and feta for the ultimate cheese lover\'s delight.',
        'image':
            'https://www.dominos.jp/media/zl0ehpr5/cheesefantasy_american.jpg',
        'price': '390',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Taco Fiesta',
        'description':
            'Seasoned ground beef, cheddar cheese, lettuce, tomatoes, and a dollop of sour cream for a taco-inspired pizza.',
        'image':
            'https://boboli.com/sites/default/files/2022-06/fiesta_LR_0.jpg',
        'price': '300',
        'isHot': false
      });
      db.insert('items', {
        'name': 'Spinach and Feta Sensation',
        'description':
            'Fresh spinach, feta cheese, and black olives create a light and flavorful pizza experience',
        'image':
            'https://www.cookitrealgood.com/wp-content/uploads/2020/06/spinachfetapizza4.jpg',
        'price': '120',
        'isHot': true
      });
      db.insert('items', {
        'name': 'Supreme Spectacle',
        'description':
            'A grand combination of pepperoni, sausage, bell peppers, onions, mushrooms, and black olives for the pizza enthusiast.',
        'image':
            'https://www.brooklynsbestpizzaandpasta.com/wp-content/uploads/2023/08/A-Supreme-Pie-from-Brooklyns-Best-Pizza-Pasta-768x432.jpg',
        'price': '99',
        'isHot': true
      });
      db.insert('items', {
        'name': 'Breakfast Bonanza',
        'description':
            ' A morning delight with bacon, scrambled eggs, and a drizzle of hollandaise sauce on a breakfast-inspired pizza crust.',
        'image':
            'https://visitfarmville.com/wp-content/uploads/2019/07/Merks-breakfast-pizza-480x319.jpg.webp',
        'price': '190',
        'isHot': true
      });
      db.insert('items', {
        'name': 'Truffle Mushroom Elegance',
        'description':
            ' Earthy mushrooms, truffle oil, and a sprinkle of parmesan elevate this pizza to gourmet status.',
        'image':
            'https://eurorich.ph/cdn/shop/articles/APC_0088_900x.jpg?v=1665678123',
        'price': '199',
        'isHot': true
      });
      db.insert('items', {
        'name': 'Caprese Charm',
        'description':
            'Slices of ripe tomatoes, fresh mozzarella, and basil drizzled with balsamic glaze for a taste of Italy.',
        'image':
            'https://i0.wp.com/www.sparklingcharm.com/wp-content/uploads/2017/02/Unknown-26.jpeg?w=2580&ssl=1',
        'price': '80',
        'isHot': true
      });
      db.insert('items', {
        'name': 'Philly Cheesesteak Supreme',
        'description':
            'Thinly sliced steak, sautéed peppers and onions, and a generous helping of melted cheese pay homage to the iconic Philly cheesesteak.',
        'image':
            'https://littlespicejar.com/wp-content/uploads/2016/10/Philly-Cheese-Steak-Pizza-7.jpg',
        'price': '180',
        'isHot': true
      });
      db.execute('''
        CREATE TABLE orders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId INTEGER,
          userName TEXT,
          phone TEXT,
          itemName TEXT,
          itemImage TEXT,
          date TEXT,
          price TEXT,
          statue TEXT,
          quantity INTEGER
        )
      ''').catchError((error) {
        print('Error creating items table: $error');
      });
    },
    onOpen: (db) {},
  ).then((value) {
    print('Database opened successfully');
    database = value;
    print(value.isOpen);
  });
}

Future<bool> loginToTheSystem(email, password) async {
  var existingUsers = await database.rawQuery(
      'select * from users where email =\'$email\' and password=\'$password\'');

  if (existingUsers.isEmpty) {
    return false;
  } else {
    users = existingUsers[0];
    return true;
  }
}

Future<void> updateInformation(userID, name, email, password) async {
  database.rawUpdate(
      'update users set name=\'$name\',email=\'$email\',password=\'$password\' where id=$userID');
  var existingUsers =
      await database.rawQuery('select * from users where id =$userID');
  users = existingUsers[0];
}

void changeOrderDetails(orderID, statue) {
  database.rawUpdate('update orders set statue=\'$statue\' where id=$orderID');
}

void changeItemsDetails(itemID, name, description, image, price, isHot) {
  database
      .rawUpdate(
          'update items set name=\'$name\',description=\'$description\',image=\'$image\',price=\'$price\',isHot=\'$isHot\' where id=$itemID')
      .then((value) {
    getItemsFromDataBase();
  });
}

void changeUsersDetails(userId, name, phone, email) {
  database
      .rawUpdate(
          'update users set name=\'$name\',phone=\'$phone\',email=\'$email\' where id=$userId')
      .then((value) {
    getItemsFromDataBase();
  });
}
