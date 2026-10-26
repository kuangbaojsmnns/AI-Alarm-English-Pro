# Flutter architecture

The Flutter client uses a feature-first structure. Cross-cutting application setup lives in `lib/app`; generic reusable infrastructure lives in `lib/core`; product capabilities live in `lib/features`.

## Feature layout

Add code inside the feature that owns the behavior:

```text
lib/features/<feature>/
├── application/             # Riverpod providers and use-case orchestration
├── data/
│   ├── datasources/         # HTTP, local storage, platform adapters
│   └── repositories/        # Repository implementations
├── domain/
│   ├── entities/            # Feature models and value types
│   └── repositories/        # Repository contracts
└── presentation/
    ├── pages/               # Route-level screens
    └── widgets/              # Feature-specific UI
```

Create only the layers a feature needs. The alarms feature includes an entity, repository contract, demo repository, Riverpod providers, and page. Home and settings include API-backed repositories and providers. Lessons, vocabulary, and profile currently start with presentation pages.

## Dependency direction

- Presentation reads state from the feature's application providers.
- Application coordinates domain behavior and exposes UI-ready state.
- Data implements domain repository contracts and owns external I/O.
- Domain stays independent of Flutter widgets, HTTP clients, and storage plugins.
- Core may be imported by any feature, but core must not import product features.
- Share a component in `core/widgets` only when it is generic across features. Keep product-specific components inside their feature.

## App-wide setup

- `main.dart`: initializes Flutter and Riverpod's `ProviderScope`.
- `app/app.dart`: root `MaterialApp.router`.
- `app/router/app_router.dart`: route declarations and top-level navigation shell.
- `app/theme/app_theme.dart`: design tokens and shared Material theme.
- `core/network/api_client.dart`: shared Dio client provider.
- `core/constants/app_constants.dart`: platform-aware API base URL and app constants.
- `core/constants` and `core/errors`: app-wide values and error types.

## Adding a page

1. Put the page in the owning feature's `presentation/pages/` directory (or alongside the current page until the feature grows).
2. Add its route to `app/router/app_router.dart`.
3. Add a bottom-navigation destination only if it is a top-level section; detail pages belong under their feature route.
4. Add feature providers, entities, and repository code in that feature only when the page needs them.

Most page additions therefore touch the feature and the centralized route table, without reshaping the project tree or changing unrelated modules.

## State and navigation

Use Riverpod providers for shared or asynchronous state. Keep ephemeral form and animation state local to widgets. Use GoRouter for deep links, nested feature routes, and the persistent indexed bottom-navigation branches.

## Settings and runtime status

The Profile branch contains a nested settings route. The settings feature requests `GET /api/status` through its own repository and provider, then presents backend health/version, authentication capability/session status, and OpenAI key presence.

The backend status payload includes only a boolean for OpenAI configuration. Never return the key to the Flutter client. Authentication currently reports disabled and signed out until an auth flow is implemented.
