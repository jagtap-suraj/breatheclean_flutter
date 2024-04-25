import 'package:flutter/material.dart';

import '../globals/channel_list.dart';

/// A widget that allows the user to select a channel from a list of channels.
class ChannelSelector extends StatefulWidget {
  final Function(int) onChannelSelected;
  final int initialChannel;
  final String createdAt;

  const ChannelSelector({
    super.key,
    required this.onChannelSelected,
    required this.initialChannel,
    required this.createdAt,
  });

  @override
  State<ChannelSelector> createState() => _ChannelSelectorState();
}

class _ChannelSelectorState extends State<ChannelSelector> {
  int? _selectedChannel;

  @override
  void initState() {
    super.initState();
    _selectedChannel = widget.initialChannel;
  }

  final List<int> _channels = channelList;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: _selectedChannel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onSelected: (channel) {
        setState(() {
          _selectedChannel = channel;
        });
        widget.onChannelSelected(channel);
      },
      itemBuilder: (context) => _channels
          .map(
            (channel) => PopupMenuItem(
              value: channel,
              child: Text('Channel ${_channels.indexOf(channel) + 1}'),
            ),
          )
          .toList(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Channel ${_channels.indexOf(_selectedChannel!) + 1}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          Text(
            widget.createdAt.isNotEmpty ? widget.createdAt : '',
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
