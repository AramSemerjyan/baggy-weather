import 'package:flutter/material.dart';
import 'package:flutter_weather/App/app_widget.dart';
import 'package:flutter_weather/DI/injectable.dart';

/// ================ Attention ================
/// Hey there! Thanks for giving me an opportunity to work with this hell... sorry... test
/// project! :) What I can say is that this was a great opportunity to understand
/// That I have to quit development... what?... to work harder to improve myself in almost
/// all possible fields in development. I'm writing this 6:00 AM at monday
/// and at this point I finally done with all REQUIRED parts of the project and
/// I really want to add more... but most probably I'll fall asleep soon...
/// ALL SYSTEMS READY TO SHUT DOWN!
/// I know that I've spent a lot more time than you expected but I just want to
/// point couple of things to justify myself (most probably this want change anything)
/// 1. I have never worked with REAL BLoC pattern. I mean in my main project
/// I used some kind of MVVM which includes ViewModel for business logic
/// and I use `injector` (https://pub.dev/packages/injector) package to prepare every need Widget with corresponding
/// ViewModel and then with help of some static params get Widget from container
/// to present. I do use BlocProvider but that is just:
/// abstract class BlocBase {
///   void dispose() {
///     print("Bloc base disposed");
///
///     disposeBag.dispose();
///   }
///
///   CompositeSubscription disposeBag = CompositeSubscription();
/// }
///
/// class BlocProvider<T extends BlocBase> extends StatefulWidget {
///   BlocProvider({
///     Key? key,
///     required this.child,
///     required this.bloc,
///   }) : super(key: key);
///
///   final T bloc;
///   final Widget child;
///
///   @override
///   _BlocProviderState<T> createState() => _BlocProviderState<T>();
///
///   static T of<T extends BlocBase>(BuildContext context) {
///     BlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
///     return provider.bloc;
///   }
/// }
///
/// class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
///   @override
///   void dispose() {
///     print("Bloc provider disposed");
///
///     widget.bloc.dispose();
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return widget.child;
///   }
/// }
/// As you can see I just gather Widget and its ViewModel in one Widget and then
/// get ViewModel inside Widget if help of `BlocProvider.of()` method.
/// Also with additional method to dispose ViewModel to close all Streams.
/// If you reading this and you still want to continue... thank you... I guess
/// already at this point you want to close the project and reject me (that would be fair)
/// especially, I can assure you that it will get worse further... anyway, I just want to
/// ask you to still have a call with me and point all things that you think is stupid...
/// or should be improved... or should be rewritten... or even in case when I should
/// burn whole project, my laptop and my current apartment and start all over again...
/// including my career.
/// 2. I have never work with localization... or with its normal implementation.
/// This was a great opportunity to write good (or I just think so) implementation
/// for it... but I spent hours to make it work as expected... because I have issues
/// issues with my brain and myself.
/// 3. I have never worked with navigation in BLoC. In my project I just use GetX (https://pub.dev/packages/get)
/// for navigation and I haven't noticed any issue with it so far... and it significantly simplify
/// everything. The concept with actions/states is pretty new for me
/// (I remembered when I first get into project with rx... that was a pain...)
/// and I still can't understand the pros of the separate Widget (NavWidget) to
/// navigate somewhere. I really like concept of streams, and in my ViewModel class
/// I use rxDart and my ViewModel just like the BLoC communicate with Widgets with help of
/// Streams and Sinks. So navigation can be done like in RXFlow (Swift package for navigation)
/// use an separate class to handle all GetX actions and when we need to navigate somewhere
/// send an enum to GetX helper and all navigation will be handled in it.
/// Anyway... thanks a lot for attention :D I'm sure that you won't waist your time
/// having a call with me... hope you just give a quick review of my code and point me
/// the major issues I have in text form. Thanks a lot :)
/// ===========================================
///
///
/// P.S.: I've just noticed that localization doesn't work on iOS (what a surprise, right?)
/// nothing works on iOS as expected... But I'm afraid I won't be able to fix this...
/// Every `flutter clean` and `flutter build` took almost 10-15 minutes for iOS ot build
/// while my `kernel_task` gets around 500-600% CPU (where does MacBook find this kind of resources)
/// and everything gets laggy and laptop just randomly freezes (even though this isn't the worst one)
/// I can assure you that if you give more time I would be able to fix everything and implement
/// every feature that is needed. I've worked with Firebase (Cloud Messaging, Firestore)
/// I can implement user data caching... but I work to slow I guess that's why I ended up
/// with broken app :D
void main() {
  AppInjection.configure();

  runApp(const App());
}
