plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.shopping_mall"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.shopping_mall"
        // Firebase Auth needs at least API 23
        minSdk = 23
        targetSdk = 35

        // these two come from your local.properties
        versionCode = (project.property("flutterVersionCode") as String).toInt()
        versionName = project.property("flutterVersionName") as String
    }

    buildTypes {
        getByName("debug") {
            isMinifyEnabled = false
        }
        getByName("release") {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    buildFeatures {
        buildConfig = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }
}

flutter {
    // adjust path if your Flutter module lives elsewhere
    source = "../.."
}
