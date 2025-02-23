import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatpar_orange/configurations/router/router.dart';
import 'package:tatpar_orange/features/case/data/repos/case_repo.dart';
import 'package:tatpar_orange/features/contacttracing/data/contact_tracing_cubit.dart';
import 'package:tatpar_orange/features/contacttracing/models/contact_tracing_model.dart';
import 'package:tatpar_orange/features/contacttracing/presentation/pages/contact_tracing_page.dart';

@RoutePage(name: 'ContactTracingRouter')
class ContactTracingRouterPage extends StatelessWidget {
  const ContactTracingRouterPage({
    super.key,
    required this.contactTracingModel,
  });

  final ContactTracingModel contactTracingModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactTracingCubit(
        repo: context.read<CaseRepo>(),
        contactTracingModel: contactTracingModel,
      ),
      child: BlocListener<ContactTracingCubit, ContactTracingState>(
          listener: (context, state) {
            context
                .read<ContactTracingCubit>()
                .updateSingleCase(state.contactTracingModel);
          },
          listenWhen: (previous, current) =>
              previous.contactTracingModel != current.contactTracingModel,
          child: const ContactTracingPage()),
    );
  }
}
