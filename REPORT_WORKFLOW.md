# ESPN weekly draft workflow

The **ESPN report draft** action checks out the latest shared engine `master`, installs ESPN dependencies, runs tests, generates the report, builds Hugo, deploys a Netlify draft, and opens a review PR when content changed. Merge the PR to publish through the existing Netlify Git integration. It never uses `--prod`. The engine revision is recorded in the run summary.

## Setup and cutover

1. Add Actions repository secrets `ESPN_S2`, `ESPN_SWID`, `NETLIFY_AUTH_TOKEN`, and **JTown's** `NETLIFY_SITE_ID` (not SYPIP's). Optionally add `OPENAI_API_KEY`. Never commit credentials. Latest shared-engine code runs with these secrets only in the relevant steps.
2. Enable GitHub Actions permission to create pull requests.
3. Run Actions → ESPN report draft → Run workflow manually. Leave week blank for detection. In preseason, the preview contains existing website content and no report PR is created. JTown AI recaps default on for manual and scheduled runs and require `OPENAI_API_KEY`; uncheck the manual input to skip AI. SYPIP settings are separate and unchanged.
4. Verify the Netlify draft. Test a completed-week report and its review PR when data is available.
5. Disable the Pi cron only after hosted validation succeeds. Then set repository **variable** `ENABLE_ESPN_SCHEDULE` to `true`.

The Tuesday schedule (14:45 UTC, September–December) is gated off until that variable is enabled. No Pi settings are modified by this workflow.

## Corrections and KTC data

Manual corrections require an explicit week and the overwrite checkbox. They reuse the saved KTC CSV; a missing snapshot stops the correction. Existing snapshots are never replaced by the scraper. Scores and roster data are fetched again, so this is not a complete historical replay.

KTC snapshots are committed in `report-data/ktc/<season>/KTC_values_weekN.csv` alongside the report changes. They are not Hugo content and are excluded from the deployed site, but are visible in this public GitHub repository. Season folders prevent cross-season mixups; old seasons may be purged at rollover and need not be preserved. Merge earlier report PRs before generating subsequent weeks/corrections so their snapshots are available on main. A draft that has not been merged is not yet an input to the next run.

Review and merge the PR rather than directly promoting a Netlify draft, so the report and KTC snapshot are saved for future runs. Re-running a workflow before merging its existing PR may create another review branch.
