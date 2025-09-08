# Environment Setup Guide

This project uses environment variables to manage sensitive configuration data like API keys and secrets. Follow these steps to set up your environment:

## 1. Create Environment File

Create a `.env` file in the root directory of the project with the following structure:

```env
# Environment Configuration
APP_ENVIRONMENT=test

# Firebase Configuration
firebase_android_key=your_firebase_android_key_here
firebase_ios_key=your_firebase_ios_key_here

# Stripe Configuration - Test Environment
STRIPE_TEST_SECRET_KEY=sk_test_your_test_secret_key_here
STRIPE_TEST_PUBLISHABLE_KEY=pk_test_your_test_publishable_key_here
STRIPE_TEST_MERCHANT_ID=acct_your_test_merchant_id_here

# Stripe Configuration - Production Environment
STRIPE_LIVE_SECRET_KEY=sk_live_your_live_secret_key_here
STRIPE_LIVE_PUBLISHABLE_KEY=pk_live_your_live_publishable_key_here
STRIPE_LIVE_MERCHANT_ID=acct_your_live_merchant_id_here
```

## 2. Environment Variables Explained

### APP_ENVIRONMENT
- Set to `test` for development/testing
- Set to `production` for live/production builds

### Stripe Keys
- **Test Keys**: Used when `APP_ENVIRONMENT=test`
- **Live Keys**: Used when `APP_ENVIRONMENT=production`
- Get these from your Stripe Dashboard

### Firebase Keys
- Used for Firebase configuration
- Get these from your Firebase Console

## 3. Security Notes

- **Never commit the `.env` file to version control**
- The `.env` file is already added to `.gitignore`
- Use different keys for different environments
- Keep your production keys secure

## 4. Current Configuration

The app will automatically use the appropriate keys based on the `APP_ENVIRONMENT` setting:

- **Test Mode**: Uses test Stripe keys and test merchant ID
- **Production Mode**: Uses live Stripe keys and live merchant ID

## 5. Troubleshooting

If you encounter issues:
1. Ensure the `.env` file exists in the project root
2. Check that all required environment variables are set
3. Verify the keys are correct and active
4. Make sure `flutter_dotenv` is properly loaded in `main.dart`
