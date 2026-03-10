# List of all files
$files = @(
    "basic_simple_percentage.html",
    "basic_fraction_decimal_percentage.html",
    "basic_percentage_increase_decrease.html",
    "basic_successive_percentage_change.html",
    "basic_percentage_of_number.html",
    "pl_profit_percentage.html",
    "pl_loss_percentage.html",
    "pl_sp_cp_relationship.html",
    "pl_discount_problems.html",
    "pl_successive_discounts.html",
    "mixture_percentage_problems.html",
    "mixture_concentration.html",
    "mixture_alligation.html",
    "average_weighted_percentage.html",
    "average_class_group.html",
    "average_combined.html",
    "average_change.html",
    "comparative_increase_decrease.html",
    "comparative_more_less.html",
    "comparative_ratio_percentage.html",
    "comparative_two_percentages.html",
    "data_tables.html",
    "data_charts.html",
    "data_distribution.html",
    "data_growth_decline.html",
    "advanced_successive_pl.html",
    "advanced_compound_interest.html",
    "advanced_percentage_error.html",
    "advanced_reverse_percentage.html",
    "advanced_mixture_multiple.html"
)

# Loop to create each file with links to all other files
foreach ($f in $files) {
    $content = @"
<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='UTF-8'>
<meta name='viewport' content='width=device-width, initial-scale=1.0'>
<title>$($f -replace '.html','')</title>
<style>
body { font-family: Arial, sans-serif; line-height: 1.6; margin: 20px; background-color: #f9f9f9; color: #333; }
h1 { color: #0056b3; }
ul { list-style-type: none; padding-left: 0; }
li { margin-bottom: 6px; }
a { text-decoration: none; color: #007bff; }
a:hover { text-decoration: underline; }
</style>
</head>
<body>
<h1>$($f -replace '.html','')</h1>
<p>Content for $($f -replace '.html','') goes here.</p>
<h2>Navigate to other files:</h2>
<ul>
"@

    foreach ($l in $files) {
        $content += "<li><a href='$l'>$($l -replace '.html','')</a></li>`n"
    }

    $content += "</ul></body></html>"

    # Write to file
    Set-Content -Path $f -Value $content
}

Write-Host "All HTML files with links created successfully!"