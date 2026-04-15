import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/features/home/presentation/screens/settings_screen.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/main_shell.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/doctors/presentation/screens/doctor_catalog_screen.dart';
import '../../features/doctors/presentation/screens/doctor_detail_screen.dart';
import '../../features/appointments/presentation/screens/appointments_screen.dart';
import '../../features/appointments/presentation/screens/booking_screen.dart';
import '../../features/patient_card/presentation/screens/patient_card_screen.dart';

// Pharmacy
import '../../features/pharmacy/domain/entities/drug_entity.dart';
import '../../features/pharmacy/presentation/screens/pharmacy_screen.dart';
import '../../features/pharmacy/presentation/screens/drug_detail_screen.dart';
import '../../features/pharmacy/presentation/screens/cart_screen.dart';
import '../../features/pharmacy/presentation/screens/checkout_screen.dart';
// Chat
import '../../features/chat/presentation/screens/message_history_screen.dart';
import '../../features/chat/presentation/screens/chat_room_screen.dart';
// Emergency
import '../../features/emergency/presentation/screens/ambulance_screen.dart';
import '../../features/emergency/presentation/screens/hospital_map_screen.dart';
// Articles & BMI
import '../../features/articles/domain/entities/article_entity.dart';
import '../../features/articles/presentation/screens/articles_screen.dart';
import '../../features/articles/presentation/screens/article_detail_screen.dart';
import '../../features/bmi/presentation/screens/bmi_screen.dart';
// Reminders
import '../../features/reminders/presentation/screens/reminders_screen.dart';
// My Reviews
import '../../features/reviews/presentation/screens/my_reviews_screen.dart';
import '../../features/reviews/presentation/screens/doctor_reviews_screen.dart';


// Route names
abstract class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const doctors = '/doctors';
  static const doctorDetail = '/doctors/:id';
  static const booking = '/booking';
  static const appointments = '/appointments';
  static const patientCard = '/profile';
  static const settings = '/settings';

    // Pharmacy
  static const pharmacy = '/pharmacy';
  static const drugDetail = '/pharmacy/drug';
  static const cart = '/pharmacy/cart';
  static const checkout = '/pharmacy/checkout';
  // Chat
  static const messages = '/messages';
  static const chatRoom = '/messages/chat';
  // Emergency
  static const emergency = '/emergency';
  static const hospitalMap = '/emergency/map';
  // Articles & BMI
  static const articles = '/articles';
  static const articleDetail = '/articles/detail';
  static const bmi = '/bmi';
  // Reminders
  static const reminders = '/reminders';
  static const myReviews = '/my-reviews';
  static const doctorReviews = '/doctor-reviews';

}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: Routes.splash,
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final loggingIn = state.matchedLocation == Routes.login ||
          state.matchedLocation == Routes.register ||
          state.matchedLocation == Routes.splash;

      if (!isLoggedIn && !loggingIn) return Routes.login;
      if (isLoggedIn && loggingIn &&
          state.matchedLocation != Routes.splash) {
        return Routes.home;
      }
      return null;
    },
    routes: [
      //  Public 
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      //  Authenticated shell (bottom nav) 
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: Routes.doctors,
            builder: (context, state) => const DoctorCatalogScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final doctorId = state.pathParameters['id']!;
                  final extra = state.extra as Map<String, dynamic>?;
                  return DoctorDetailScreen(
                    doctorId: doctorId,
                    extra: extra,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.appointments,
            builder: (context, state) => const AppointmentsScreen(),
          ),
          GoRoute(
            path: Routes.patientCard,
            builder: (context, state) => const PatientCardScreen(),
          ),
          GoRoute(
  path: Routes.settings,
  builder: (context, state) => const SettingsScreen(),
),

          GoRoute(path: Routes.pharmacy, builder: (_, __) => const PharmacyScreen()),
          GoRoute(path: Routes.messages, builder: (_, __) => const MessageHistoryScreen()),
          GoRoute(path: Routes.emergency, builder: (_, __) => const AmbulanceScreen()),
          GoRoute(path: Routes.articles, builder: (_, __) => const ArticlesScreen()),
          GoRoute(path: Routes.reminders, builder: (_, __) => const RemindersScreen()),
          GoRoute(path: Routes.myReviews, builder: (_, __) => const MyReviewsScreen()),


        ],
      ),

      //  Booking (full-screen, outside shell) 
      GoRoute(
        path: Routes.booking,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return BookingScreen(extra: extra);
        },
      ),

       GoRoute(
        path: Routes.drugDetail,
        builder: (context, state) =>
            DrugDetailScreen(drug: state.extra as DrugEntity),
      ),
      GoRoute(path: Routes.cart, builder: (_, __) => const CartScreen()),
      GoRoute(path: Routes.checkout, builder: (_, __) => const CheckoutScreen()),
      GoRoute(
        path: Routes.chatRoom,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return ChatRoomScreen(
            conversationId: extra['conversationId'] as String,
            doctorName: extra['doctorName'] as String,
            doctorAvatarUrl: extra['doctorAvatarUrl'] as String,
            doctorSpecialty: extra['doctorSpecialty'] as String,
          );
        },
      ),
      GoRoute(path: Routes.hospitalMap, builder: (_, __) => const HospitalMapScreen()),
      GoRoute(
        path: Routes.articleDetail,
        builder: (context, state) =>
            ArticleDetailScreen(article: state.extra as ArticleEntity),
      ),
      GoRoute(path: Routes.bmi, builder: (_, __) => const BmiScreen()),
      GoRoute(
        path: Routes.doctorReviews,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return DoctorReviewsScreen(
            doctorId: extra['doctorId'] as String,
            doctorName: extra['doctorName'] as String,
          );
        },
      ),
    ],
  );
});
