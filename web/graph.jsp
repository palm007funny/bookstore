<!DOCTYPE html>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<meta charset="utf-8">
<h1><center> Report </center></h1>
<%@include  file="template/head.jsp"%><br>
<%
    Connection connect = null;
    Statement s = null;
    db.doConnection();
    s = db.getConnection().createStatement();
    String category = null;
    int[] num = new int[9];
    PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM book");
    ResultSet result = ps.executeQuery();
    while (result.next()) {
        category = result.getString("category");
        if (category.equals("000")) {
            num[0] = num[0] + 1;
        }
        if (category.equals("100")) {
            num[1] = num[1] + 1;
        }
        if (category.equals("200")) {
            num[2] = num[2] + 1;
        }
        if (category.equals("300")) {
            num[3] = num[3] + 1;
        }
        if (category.equals("400")) {
            num[4] = num[4] + 1;
        }
        if (category.equals("500")) {
            num[5] = num[5] + 1;
        }
        if (category.equals("600")) {
            num[6] = num[6] + 1;
        }
        if (category.equals("700")) {
            num[7] = num[7] + 1;
        }
        if (category.equals("800")) {
            num[8] = num[8] + 1;
        }
        if (category.equals("900")) {
            num[9] = num[9] + 1;
        }
    }
    ps.close();
    result.close();
    db.endConnection();
%>
<style>
    path {  stroke: #fff; }
    path:hover {  opacity:0.9; }
    rect:hover {  fill:blue; }
    .axis {  font: 10px sans-serif; }
    .legend tr{    
        border-bottom:1px solid grey; 
    }
    .legend tr:first-child{    
        border-top:1px solid grey;
    }
    .axis path,
    .axis line {
        fill: none;
        stroke: #000;
        shape-rendering: crispEdges;
    }

    .x.axis path {  display: none; }
    .legend{
        position:absolute;
        left:300px;
        top:180px;
        margin-bottom:0px;
        display:inline-block;
        border-collapse: collapse;
        border-spacing: 0px;
    }
    .legend td{
        padding:4px 5px;
        vertical-align:bottom;
    }
    .legendFreq, .legendPerc{
        width:50px;
    }
    .node rect {  
        cursor: pointer;
        fill: #fff;
        fill-opacity: .5;
        stroke: #3182bd;
        stroke-width: 1.5px;
    }

    .node text {
        font: 10px sans-serif;
        pointer-events: none;
    }

    path.link {
        fill: none;
        stroke: #9ecae1;
        stroke-width: 1.5px;
    }
</style>   

<div id='dashboard'>

    <script src="js/d3.min.js"></script>
    <script>
        function dashboard(id, fData) {
            var barColor = 'steelblue';
            function segColor(c) {
                return {ทั่วไป: "#807dba", จิตวิทยา: "#e08214", ศาสนา: "#41ab5d", ภาษา: "#ff66cc", วิทยาศาสตร์: "#ffff00"
                    , กีฬาเกม: "#ff0000", การ์ตูน: "#0000cc", วรรณกรรม: "#66ffff"}[c];
            }

            // compute total for each state.
            fData.forEach(function (d) {
                d.total = d.freq.low + d.freq.mid + d.freq.high;
            });

            // function to handle histogram.
            function histoGram(fD) {
                var hG = {}, hGDim = {t: 60, r: 0, b: 30, l: 0};
                hGDim.w = 500 - hGDim.l - hGDim.r,
                        hGDim.h = 300 - hGDim.t - hGDim.b;

                //create svg for histogram.
                var hGsvg = d3.select(id).append("svg")
                        .attr("width", hGDim.w + hGDim.l + hGDim.r)
                        .attr("height", hGDim.h + hGDim.t + hGDim.b).append("g")
                        .attr("transform", "translate(" + hGDim.l + "," + hGDim.t + ")");

                // create function for x-axis mapping.
                var x = d3.scale.ordinal().rangeRoundBands([0, hGDim.w], 0.1)
                        .domain(fD.map(function (d) {
                            return d[0];
                        }));

                // Add x-axis to the histogram svg.
                hGsvg.append("g").attr("class", "x axis")
                        .attr("transform", "translate(0," + hGDim.h + ")")
                        .call(d3.svg.axis().scale(x).orient("bottom"));

                // Create function for y-axis map.
                var y = d3.scale.linear().range([hGDim.h, 0])
                        .domain([0, d3.max(fD, function (d) {
                                return d[1];
                            })]);

                // Create bars for histogram to contain rectangles and freq labels.
                var bars = hGsvg.selectAll(".bar").data(fD).enter()
                        .append("g").attr("class", "bar");

                //create the rectangles.
                bars.append("rect")
                        .attr("x", function (d) {
                            return x(d[0]);
                        })
                        .attr("y", function (d) {
                            return y(d[1]);
                        })
                        .attr("width", x.rangeBand())
                        .attr("height", function (d) {
                            return hGDim.h - y(d[1]);
                        })
                        .attr('fill', barColor)
                        .on("mouseover", mouseover)// mouseover is defined below.
                        .on("mouseout", mouseout);// mouseout is defined below.

                //Create the frequency labels above the rectangles.
                bars.append("text").text(function (d) {
                    return d3.format(",")(d[1])
                })
                        .attr("x", function (d) {
                            return x(d[0]) + x.rangeBand() / 2;
                        })
                        .attr("y", function (d) {
                            return y(d[1]) - 5;
                        })
                        .attr("text-anchor", "middle");

                function mouseover(d) {  // utility function to be called on mouseover.
                    // filter for selected state.
                    var st = fData.filter(function (s) {
                        return s.State == d[0];
                    })[0],
                            nD = d3.keys(st.freq).map(function (s) {
                        return {type: s, freq: st.freq[s]};
                    });

                    // call update functions of pie-chart and legend.    
                    pC.update(nD);
                    leg.update(nD);
                }

                function mouseout(d) {    // utility function to be called on mouseout.
                    // reset the pie-chart and legend.    
                    pC.update(tF);
                    leg.update(tF);
                }

                // create function to update the bars. This will be used by pie-chart.
                hG.update = function (nD, color) {
                    // update the domain of the y-axis map to reflect change in frequencies.
                    y.domain([0, d3.max(nD, function (d) {
                            return d[1];
                        })]);

                    // Attach the new data to the bars.
                    var bars = hGsvg.selectAll(".bar").data(nD);

                    // transition the height and color of rectangles.
                    bars.select("rect").transition().duration(500)
                            .attr("y", function (d) {
                                return y(d[1]);
                            })
                            .attr("height", function (d) {
                                return hGDim.h - y(d[1]);
                            })
                            .attr("fill", color);

                    // transition the frequency labels location and change value.
                    bars.select("text").transition().duration(500)
                            .text(function (d) {
                                return d3.format(",")(d[1])
                            })
                            .attr("y", function (d) {
                                return y(d[1]) - 5;
                            });
                }
                return hG;
            }

            // function to handle pieChart.
            function pieChart(pD) {
                var pC = {}, pieDim = {w: 250, h: 250};
                pieDim.r = Math.min(pieDim.w, pieDim.h) / 2;

                // create svg for pie chart.
                var piesvg = d3.select(id).append("svg")
                        .attr("width", pieDim.w).attr("height", pieDim.h).append("g")
                        .attr("transform", "translate(" + pieDim.w / 2 + "," + pieDim.h / 2 + ")");

                // create function to draw the arcs of the pie slices.
                var arc = d3.svg.arc().outerRadius(pieDim.r - 10).innerRadius(0);

                // create a function to compute the pie slice angles.
                var pie = d3.layout.pie().sort(null).value(function (d) {
                    return d.freq;
                });

                // Draw the pie slices.
                piesvg.selectAll("path").data(pie(pD)).enter().append("path").attr("d", arc)
                        .each(function (d) {
                            this._current = d;
                        })
                        .style("fill", function (d) {
                            return segColor(d.data.type);
                        })
                        .on("mouseover", mouseover).on("mouseout", mouseout);

                // create function to update pie-chart. This will be used by histogram.
                pC.update = function (nD) {
                    piesvg.selectAll("path").data(pie(nD)).transition().duration(500)
                            .attrTween("d", arcTween);
                }
                // Utility function to be called on mouseover a pie slice.
                function mouseover(d) {
                    // call the update function of histogram with new data.
                    hG.update(fData.map(function (v) {
                        return [v.State, v.freq[d.data.type]];
                    }), segColor(d.data.type));
                }
                //Utility function to be called on mouseout a pie slice.
                function mouseout(d) {
                    // call the update function of histogram with all data.
                    hG.update(fData.map(function (v) {
                        return [v.State, v.total];
                    }), barColor);
                }
                // Animating the pie-slice requiring a custom function which specifies
                // how the intermediate paths should be drawn.
                function arcTween(a) {
                    var i = d3.interpolate(this._current, a);
                    this._current = i(0);
                    return function (t) {
                        return arc(i(t));
                    };
                }
                return pC;
            }

            // function to handle legend.
            function legend(lD) {
                var leg = {};

                // create table for legend.
                var legend = d3.select(id).append("table").attr('class', 'legend');

                // create one row per segment.
                var tr = legend.append("tbody").selectAll("tr").data(lD).enter().append("tr");

                // create the first column for each segment.
                tr.append("td").append("svg").attr("width", '16').attr("height", '16').append("rect")
                        .attr("width", '16').attr("height", '16')
                        .attr("fill", function (d) {
                            return segColor(d.type);
                        });

                // create the second column for each segment.
                tr.append("td").text(function (d) {
                    return d.type;
                });

                // create the third column for each segment.
                tr.append("td").attr("class", 'legendFreq')
                        .text(function (d) {
                            return d3.format(",")(d.freq);
                        });

                // create the fourth column for each segment.
                tr.append("td").attr("class", 'legendPerc')
                        .text(function (d) {
                            return getLegend(d, lD);
                        });

                // Utility function to be used to update the legend.
                leg.update = function (nD) {
                    // update the data attached to the row elements.
                    var l = legend.select("tbody").selectAll("tr").data(nD);

                    // update the frequencies.
                    l.select(".legendFreq").text(function (d) {
                        return d3.format(",")(d.freq);
                    });

                    // update the percentage column.
                    l.select(".legendPerc").text(function (d) {
                        return getLegend(d, nD);
                    });
                }

                function getLegend(d, aD) { // Utility function to compute percentage.
                    return d3.format("%")(d.freq / d3.sum(aD.map(function (v) {
                        return v.freq;
                    })));
                }

                return leg;
            }

            // calculate total frequency by segment for all state.
            var tF = ['ทั่วไป', 'จิตวิทยา', 'ศาสนา', 'ภาษา', 'วิทยาศาสตร์', 'กีฬาเกม', 'การ์ตูน', 'วรรณกรรม'].map(function (d) {
                return {type: d, freq: d3.sum(fData.map(function (t) {
                        return t.freq[d];
                    }))};
            });

            // calculate total frequency by state for all segment.
            var sF = fData.map(function (d) {
                return [d.State, d.total];
            });

            var hG = histoGram(sF), // create the histogram.
                    pC = pieChart(tF), // create the pie-chart.
                    leg = legend(tF);  // create the legend.
        }
    </script>
</div>
<script>
    var freqData = [
        {State: 'AL', freq: {ทั่วไป:<%= num[0]%>, จิตวิทยา:<%= num[1]%>, ศาสนา:<%= num[2]%>, ภาษา:<%= num[4]%>, วิทยาศาสตร์:<%= num[5]%>, กีฬาเกม:<%= num[6]%>, การ์ตูน:<%= num[7]%>, วรรณกรรม:<%= num[8]%>}}
        , {State: 'AZ', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
        , {State: 'CT', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
        , {State: 'DE', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
        , {State: 'FL', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
        , {State: 'GA', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
        , {State: 'IA', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
        , {State: 'IL', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
        , {State: 'IN', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
        , {State: 'KS', freq: {low: 10, mid: 10, high: 10, highq: 10, highq1: 10, highq2: 10, highq3: 10, highq4: 10, highq5: 10}}
    ];
    dashboard('#dashboard', freqData);
</script>
