import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                'Playback Quality',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 16),
              _buildQualityOption(context, 'Standard (64 kbps)', 64, state.streamQualityKbps),
              _buildQualityOption(context, 'High (128 kbps)', 128, state.streamQualityKbps),
              _buildQualityOption(context, 'Lossless (256 kbps)', 256, state.streamQualityKbps),
              
              const SizedBox(height: 48),
              
              Text(
                'Content Filters',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeThumbColor: AppColors.primary,
                title: Text(
                  'Hide Explicit Content',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                subtitle: Text(
                  'Blocks tracks flagged as explicit from the search results.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                value: state.filterExplicit,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(ToggleExplicitFilter(filterEnabled: value));
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQualityOption(BuildContext context, String title, int kbps, int currentKbps) {
    final isSelected = kbps == currentKbps;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        context.read<SettingsBloc>().add(UpdateStreamQuality(kbps: kbps));
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : const Icon(Icons.circle_outlined, color: AppColors.textSecondary),
    );
  }
}
