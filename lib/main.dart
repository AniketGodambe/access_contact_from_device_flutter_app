// import 'package:contacts_service/contacts_service.dart';

import 'package:access_contact_from_device_flutter_app/test_page.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact> contacts = const [];
  String? string;
  bool isLoad = false;
  final scrollController = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    loadContacts();
    super.initState();
  }

  Future<void> loadContacts() async {
    try {
      await Permission.contacts.request();
      isLoad = true;
      if (mounted) setState(() {});
      final sw = Stopwatch()..start();
      contacts = await FastContacts.getAllContacts();
      sw.stop();
      string =
          'Contacts: ${contacts.length}\nTook: ${sw.elapsedMilliseconds}ms';
    } on PlatformException catch (e) {
      string = 'Failed to get contacts:\n${e.details}';
    } finally {
      isLoad = false;
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Access Contatct Demo '),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              loadContacts();
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(16),
              // width: Get.width,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.blue),
              child: isLoad
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Load Contacts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              itemCount: contacts.length,
              itemBuilder: (_, index) => ContactItem(contact: contacts[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_upward),
        onPressed: () {
          if (scrollController.hasClients) {
            scrollController.animateTo(1,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeIn);
          }
        },
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  const ContactItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final phonesNumber = contact.phones.map((e) => e.number).join(', ');
    final emailId = contact.emails.map((e) => e.address).join(', ');
    final contactsName = contact.structuredName;
    final nameStr = contactsName != null
        ? [
            if (contactsName.namePrefix.isNotEmpty) contactsName.namePrefix,
            if (contactsName.givenName.isNotEmpty) contactsName.givenName,
            if (contactsName.middleName.isNotEmpty) contactsName.middleName,
            if (contactsName.familyName.isNotEmpty) contactsName.familyName,
            if (contactsName.nameSuffix.isNotEmpty) contactsName.nameSuffix,
          ].join(', ')
        : '';
    final companyName = contact.organization;
    final organizationStr = companyName != null
        ? [
            if (companyName.company.isNotEmpty) companyName.company,
            if (companyName.department.isNotEmpty) companyName.department,
            if (companyName.jobDescription.isNotEmpty)
              companyName.jobDescription,
          ].join(', ')
        : '';
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: ListTile(
        leading: ContactImage(contact: contact),
        title: Text(
          contact.displayName == ""
              ? "Unkwon Number"
              : contact.displayName.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Phone: ${phonesNumber.isNotEmpty ? phonesNumber : "NA"}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              "email Id: ${emailId.isNotEmpty ? emailId : "NA"}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              "Name: ${nameStr.isNotEmpty ? nameStr : "NA"}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              "Company: ${organizationStr.isNotEmpty ? organizationStr : "NA"}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactImage extends StatefulWidget {
  final Contact contact;
  const ContactImage({
    super.key,
    required this.contact,
  });

  @override
  State<ContactImage> createState() => _ContactImageState();
}

class _ContactImageState extends State<ContactImage> {
  late Future<Uint8List?> imageFuture;

  @override
  void initState() {
    super.initState();
    imageFuture = FastContacts.getContactImage(widget.contact.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: imageFuture,
      builder: (context, snapshot) => SizedBox(
          child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: snapshot.hasData
              ? Image.memory(snapshot.data!, gaplessPlayback: true)
              : const Icon(Icons.account_box_rounded),
        ),
      )),
    );
  }
}
