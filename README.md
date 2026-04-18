# helm-update-values-workflow
## steps
1. add/update route file in environment routes directory (e.g., cidm/dev,
   cidm/test, etc.)
2. push changes to repo
3. wait a short amount of time (normally < 1 min) for github action to finish
   and see changes in whichever values.yaml changed due to the routes files
   themselves changing
