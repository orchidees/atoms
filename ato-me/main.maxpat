{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 5,
			"minor" : 1,
			"revision" : 9
		}
,
		"rect" : [ 606.0, 376.0, 50.0, 24.0 ],
		"bglocked" : 0,
		"defrect" : [ 606.0, 376.0, 50.0, 24.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 0,
		"enablevscroll" : 0,
		"devicewidth" : 0.0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "mousefilter",
					"numinlets" : 1,
					"patching_rect" : [ 247.0, 125.0, 69.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-3",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "pictctrl",
					"varname" : "powerButton",
					"numinlets" : 1,
					"patching_rect" : [ 366.0, 73.0, 96.0, 90.0 ],
					"presentation" : 1,
					"numoutlets" : 1,
					"name" : "powerButton.png",
					"outlettype" : [ "int" ],
					"id" : "obj-9",
					"presentation_rect" : [ 465.0, 67.0, 61.0, 57.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route startingAnimation",
					"numinlets" : 1,
					"patching_rect" : [ 28.0, 299.0, 134.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"id" : "obj-11",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"numinlets" : 1,
					"patching_rect" : [ 56.0, 366.0, 60.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"id" : "obj-19",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "fromsymbol",
					"numinlets" : 1,
					"patching_rect" : [ 28.0, 342.0, 73.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-68",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "clear",
					"numinlets" : 2,
					"patching_rect" : [ 56.0, 391.0, 37.0, 18.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-67",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "lcd",
					"varname" : "mainTitle",
					"numinlets" : 1,
					"border" : 0,
					"patching_rect" : [ 28.0, 428.0, 128.0, 128.0 ],
					"presentation" : 1,
					"numoutlets" : 4,
					"bgtransparent" : 1,
					"outlettype" : [ "list", "list", "int", "" ],
					"id" : "obj-58",
					"presentation_rect" : [ 0.0, 2.0, 543.0, 78.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "solutionsBang",
					"numinlets" : 2,
					"patching_rect" : [ 177.0, 48.0, 86.0, 18.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-6",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "readyBang",
					"numinlets" : 2,
					"patching_rect" : [ 295.0, 42.0, 69.0, 18.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-10",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r readyBanger",
					"numinlets" : 0,
					"patching_rect" : [ 295.0, 17.0, 87.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-8",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "bpatcher",
					"numinlets" : 1,
					"args" : [  ],
					"patching_rect" : [ 177.0, 373.0, 128.0, 128.0 ],
					"presentation" : 1,
					"numoutlets" : 0,
					"name" : "target.maxpat",
					"id" : "obj-7",
					"presentation_rect" : [ 3.0, 318.0, 552.0, 406.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"numinlets" : 1,
					"patching_rect" : [ 28.0, 15.0, 60.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"id" : "obj-5",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "bpatcher",
					"varname" : "serverPanel",
					"numinlets" : 1,
					"args" : [  ],
					"patching_rect" : [ 319.0, 511.0, 130.0, 118.0 ],
					"presentation" : 1,
					"numoutlets" : 0,
					"name" : "server.maxpat",
					"bgcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-2",
					"presentation_rect" : [ -1.0, 138.0, 543.0, 210.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend screenSize",
					"numinlets" : 1,
					"patching_rect" : [ 28.0, 71.0, 117.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-55",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "screensize",
					"numinlets" : 1,
					"patching_rect" : [ 28.0, 44.0, 68.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"outlettype" : [ "list", "list" ],
					"id" : "obj-50",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "fromsymbol",
					"numinlets" : 1,
					"patching_rect" : [ 127.0, 243.0, 73.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-27",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "thispatcher",
					"numinlets" : 1,
					"patching_rect" : [ 127.0, 274.0, 69.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"id" : "obj-63",
					"fontname" : "Arial",
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "fromsymbol",
					"numinlets" : 1,
					"patching_rect" : [ 211.0, 245.0, 73.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-57",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "pictctrl",
					"numinlets" : 1,
					"patching_rect" : [ 430.0, 115.0, 0.0, 0.0 ],
					"snap" : 1,
					"numoutlets" : 1,
					"name" : "",
					"outlettype" : [ "int" ],
					"tracking" : 1,
					"id" : "obj-51"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jsui",
					"numinlets" : 1,
					"border" : 0,
					"filename" : "main.js",
					"patching_rect" : [ 28.0, 100.0, 106.0, 106.0 ],
					"numoutlets" : 3,
					"background" : 1,
					"outlettype" : [ "", "", "" ],
					"id" : "obj-62",
					"jsarguments" : [  ],
					"nofsaa" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "bpatcher",
					"varname" : "toolbarPatch",
					"numinlets" : 1,
					"args" : [  ],
					"patching_rect" : [ 319.0, 371.0, 128.0, 128.0 ],
					"presentation" : 1,
					"numoutlets" : 0,
					"name" : "toolbar.maxpat",
					"id" : "obj-1",
					"presentation_rect" : [ 0.0, -1.0, 543.0, 66.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "bpatcher",
					"varname" : "solutionsBrowser",
					"numinlets" : 1,
					"args" : [  ],
					"patching_rect" : [ 300.0, 400.0, 128.0, 128.0 ],
					"presentation" : 1,
					"numoutlets" : 0,
					"name" : "solutions.browser.maxpat",
					"id" : "obj-18",
					"presentation_rect" : [ 545.0, 0.0, 588.0, 737.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-62", 2 ],
					"destination" : [ "obj-57", 0 ],
					"hidden" : 0,
					"midpoints" : [ 124.5, 208.0, 220.5, 208.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-63", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-62", 1 ],
					"destination" : [ "obj-27", 0 ],
					"hidden" : 0,
					"midpoints" : [ 81.0, 222.0, 136.5, 222.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-50", 0 ],
					"destination" : [ "obj-55", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-55", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [ 37.5, 86.5, 37.5, 86.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-50", 0 ],
					"hidden" : 0,
					"midpoints" : [ 37.5, 35.5, 37.5, 35.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [ 304.5, 94.5, 37.5, 94.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [ 186.5, 94.5, 37.5, 94.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-67", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-68", 0 ],
					"destination" : [ "obj-58", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-67", 0 ],
					"destination" : [ "obj-58", 0 ],
					"hidden" : 0,
					"midpoints" : [ 65.5, 418.0, 37.5, 418.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-62", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 1 ],
					"destination" : [ "obj-68", 0 ],
					"hidden" : 0,
					"midpoints" : [ 152.5, 332.0, 37.5, 332.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
