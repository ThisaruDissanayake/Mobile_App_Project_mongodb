import 'package:flutter/material.dart';

class CustomerSpacer extends StatefulWidget {
  const CustomerSpacer({super.key});

  @override
  State<CustomerSpacer> createState() => _CustomerSpacerState();
}

class _CustomerSpacerState extends State<CustomerSpacer> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25,
    );
  }
}