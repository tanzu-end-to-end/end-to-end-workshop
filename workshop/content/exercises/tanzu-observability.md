Octant is great for exploring Kubernetes cluster information, but you might want to have a view of longer term performance data for your application.  Tanzu Observability provides a enterprise observability to examine not only your application metrics, but also the metrics of all the infrastructure supporting your application.

In the "Console" tab we were using for Octant, click on the "Applications" section on the left bar of the UI.  Click on the "spring-petclinic" link in the resulting tiles in the center of the UI.

Click on the "spring-petclinic-<random-number>" Pod at the top of the tree graph.  In the tile that appears on the right side of the UI, click on one of the green heptagons to bring up the details for one of the pods.

Next, click on the "Logs" tab.  Under the "Since" label, select "Creation" item from the dropdown.  In the "Filter" textbox, type "one-time use link" and navigate to the found text.  Copy the link in the line after that entry in the log, and paste it into a new browser tab.

After accessing your dashboard, you will see the collected statistics for the Pet Clinic application.  The default dashboard is useful, but you will need to clone it if you want to make any modifications.  For examply, it would be great to see events on the dashboard whenever our application gets deployed.  Click on the three vertical dots in the grey bar nearest to the top of the page, and select "Clone" to make an editable copy of the dashboard.

Give the new dashboard a name, and click "Clone".
In the cloned dashboard you created, click the three vertical dots on the right side of the UI in the grey bar closest to the top of the page.  Select "Edit".

In the edit view, click the "Settings" link to the left of the "Cancel" and "Save" buttons.

In the resulting dialog, open up the "Advanced" section by clicking on it.  In the "Event Query" text box, copy and paste the following text

```copy
events(name="spring-petclinic-deploy")
```

Click accept to save your modifications to the event query.

Click on the "Save" button in the upper right of the UI to save your changes to the dashboard.

Now, you will be returned to your cloned copy of the application dashboard.  Just under the "Search for dashboards" text box on the top right of the UI, there is a dropdown labeled "Show Events".  Click the dropdown and select the "from dashboard settings" option.  Now, you will see a small blue dot graphs that show data over time.  Hover over the blue dot to see information about the custom event we published from the CD pipeline job.  This is super useful to be able to quickly tie back any performance changes to deployments.  Events are quite flexible.  You can read more about events in Tanzu Observability at https://docs.wavefront.com/events.html.