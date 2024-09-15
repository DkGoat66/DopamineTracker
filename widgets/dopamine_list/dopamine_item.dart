import 'package:dopamine_tracker/models/dopamine.dart';
import 'package:flutter/material.dart';

class dopamineItem extends StatelessWidget {
  const dopamineItem(this.dopamine, {super.key});

  final Dopamine dopamine;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
        Text(dopamine.title,style: Theme.of(context).textTheme.titleLarge,),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text('\$${dopamine.amount.toStringAsFixed(2)}'),
            const Spacer(),
            Row(
              children: [
                 Icon(categoryIcons[dopamine.catergory]),
                 const SizedBox(width: 8),
                 Text(dopamine.formattedDate),
              ],
            ),
            ],
        )
      ]),
    ));
  }
}
