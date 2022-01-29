part of 'pages.dart';

class DetailItemPage extends StatefulWidget {
  final Item data;
  const DetailItemPage({Key? key, required this.data}) : super(key: key);

  @override
  _DetailItemPageState createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          'Detail Product',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Image.network(
              widget.data.cover,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.name,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  moneyChanger(double.parse(widget.data.price.toString())),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black38,
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 25),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Description',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.data.desc,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
