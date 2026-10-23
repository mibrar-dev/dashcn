// Collage form cards: inputs, goal, tabs, switches, radio (P6-P1 split).
//
// Split from `collage_cards.dart` to keep every docs widget file under the
// ~400-line rule. Shares the [CollageCard] shell from that file.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/input/input.dart';
import '../ui/dashcn/components/radio_group/radio_group.dart';
import '../ui/dashcn/components/switch/switch.dart';
import '../ui/dashcn/components/tabs/tabs.dart';
import '../ui/dashcn/foundation/component_preview.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'docs_tokens.dart';

class CollageInputsCard extends StatelessWidget {
  const CollageInputsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      children: <Widget>[
        Input(hintText: docsSample(context, 'Name')),
        const Gap(12),
        Input(hintText: docsSample(context, 'Message'), maxLines: 3),
      ],
    );
  }
}

class CollageGoalCard extends StatelessWidget {
  const CollageGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Set a goal'),
      subtitle: docsSample(
        context,
        docsSample(context, 'Small forms built from the same primitives'),
      ),
      children: <Widget>[
        Input(hintText: docsSample(context, 'Goal name')),
        const Gap(8),
        Row(
          children: <Widget>[
            Expanded(child: Input(hintText: docsSample(context, 'Target'))),
            const Gap(8),
            Expanded(child: Input(hintText: docsSample(context, 'Date'))),
          ],
        ),
        const Gap(12),
        SizedBox(
          width: double.infinity,
          child: Button(
            size: ButtonSize.sm,
            onPressed: collageNoop,
            child: Text(docsSample(context, 'Create Goal')),
          ),
        ),
        const Gap(8),
        SizedBox(
          width: double.infinity,
          child: Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: collageNoop,
            child: Text(docsSample(context, 'Cancel')),
          ),
        ),
      ],
    );
  }
}

class CollageTabsCard extends StatefulWidget {
  const CollageTabsCard({super.key});

  @override
  State<CollageTabsCard> createState() => CollageTabsCardState();
}

class CollageTabsCardState extends State<CollageTabsCard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      children: <Widget>[
        Tabs(
          index: _index,
          onChanged: (int index) => setState(() => _index = index),
          // The 3-column collage narrows this card to ~263 px at 1024, where
          // intrinsic-width tabs overflow by ~9 px; expanded tabs share the
          // width instead (responsive audit finding).
          expand: true,
          children: <TabItem>[
            TabItem(child: Text(docsSample(context, 'Preview'))),
            TabItem(child: Text(docsSample(context, 'Code'))),
            TabItem(child: Text(docsSample(context, 'Usage'))),
          ],
        ),
        const Gap(12),
        Text(
          docsSample(context, switch (_index) {
            0 => docsSample(context, 'Live component preview.'),
            1 => docsSample(context, 'Copy the source you install.'),
            _ => docsSample(context, 'Compose it with your own data.'),
          }),
          style: docsText(
            context,
            size: 13,
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

class CollageSwitchesCard extends StatefulWidget {
  const CollageSwitchesCard({super.key});

  @override
  State<CollageSwitchesCard> createState() => CollageSwitchesCardState();
}

class CollageSwitchesCardState extends State<CollageSwitchesCard> {
  bool _first = true;
  bool _second = false;
  bool _third = true;

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Switches'),
      children: <Widget>[
        Switch(
          value: _first,
          onChanged: (bool value) => setState(() => _first = value),
          label: Text(docsSample(context, 'Notifications')),
        ),
        const Gap(8),
        Switch(
          value: _second,
          onChanged: (bool value) => setState(() => _second = value),
          label: Text(docsSample(context, 'Weekly digest')),
        ),
        const Gap(8),
        Switch(
          value: _third,
          onChanged: (bool value) => setState(() => _third = value),
          label: Text(docsSample(context, 'Beta features')),
        ),
      ],
    );
  }
}

class CollageRadioCard extends StatefulWidget {
  const CollageRadioCard({super.key});

  @override
  State<CollageRadioCard> createState() => CollageRadioCardState();
}

class CollageRadioCardState extends State<CollageRadioCard> {
  String _value = 'pro';

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Choose a plan'),
      children: <Widget>[
        RadioSet<String>(
          value: _value,
          onChanged: (String value) => setState(() => _value = value),
          items: <Widget>[
            RadioItem<String>(
              value: 'free',
              label: Text(docsSample(context, 'Free')),
            ),
            RadioItem<String>(
              value: 'pro',
              label: Text(docsSample(context, 'Pro')),
            ),
            RadioItem<String>(
              value: 'team',
              label: Text(docsSample(context, 'Team')),
            ),
          ],
        ),
      ],
    );
  }
}
