# Processing issues regarding Beyond sidebar

These are guidelines on how to process issues associated with the label `api-docs-update`.

Changes based on issues with that label are restricted to the file `beyond-sidebar.yml`

Check the data provided in the issue for the addition or removal of endpoints or changed titles of existing endpoints.

Adjust the `beyond-sidebar.yml` file based on those aspects following the existing pattern within the file.

If it seems that there is no change that needs to be communicated, please add a comment at the ongoing pull request explaining this.

## Structure of `beyond-sidebar.yml`

- Make sure the individual resources within the API reference block are in alphabetical order
- The endpoints within a resource do not follow alphabetical order!
- Make sure the sidebar entry is placed in the same place like within the associated .adoc file provided in the issue
- Make sure that the path of the link matches the repository from which the issue has been created initiated, e.g. `ng-shop-shop-public-api.html` for `ng-shop`.
- Make sure the part after the hashtag of the path is identical with the anchor introducing an endpoint in the associated .adoc file provided in the issue, e.g. `#resources-shop-features-list` and `[[resources-shop-features-list]]` in `feature-assignments.adoc`
- The `id` is the title in lowercase letters seperated by hyphens
- Do not change the `id` when a title of an endpoint is updated in order to keep existing links intact
- Always choose the correct level for the newly added endpoint within the `beyond-sidebar.yml`
- When a endpoint has been removed, remove all three associated lines in the `beyond-sidebar.yml`, i.e. `title`, `link` and `id`