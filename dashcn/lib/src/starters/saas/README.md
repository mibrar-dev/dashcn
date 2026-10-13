# SaaS starter (`saas`)

Auth plus onboarding into a responsive shell with dashboard, pricing and settings.

## Routes

- `/signin` — `auth-01` flow (sign in, sign up, OTP, forgot password).
- `/welcome` — `onboarding-01` flow (intro pages plus permission ask).
- `/dashboard` — `dashboard-01` block (stats, chart, recent table).
- `/pricing` — `pricing-01` block (three plans plus promo form).
- `/settings` — `settings-01` flow (grouped list, nested pages, toggles).

The shell shows a sidebar rail on wide screens and a bottom tab bar on
narrow ones. Flows report through callbacks into the app's own
`SaasRepository` (`lib/data/repository.dart`, marked replace-with-backend);
the kit holds no backend.

## Create

```sh
dashcn create saas my_app
dashcn create saas my_app --theme vercel --mode package
```

`--theme` takes one of the 43 registry presets or a `file.css` web theme
(imported with the P9-4 bridge). `--mode package` depends on the `dashcn`
package; `--mode copy` owns the sources under `lib/ui/dashcn/`.
