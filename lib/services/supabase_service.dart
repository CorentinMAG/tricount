import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tricount/utils/constants.dart';

class SupabaseManager {

  static final SupabaseManager instance = SupabaseManager._internal();

  static SupabaseClient get supabase => Supabase.instance.client;


  SupabaseManager._internal();

  Future<void> initialize() async {
    await Supabase.initialize(
    url: Environment.auth["url"]!,
    anonKey: Environment.auth["anonKey"]!
    );
  }
}