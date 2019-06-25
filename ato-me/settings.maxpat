{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 5,
			"minor" : 1,
			"revision" : 9
		}
,
		"rect" : [ 162.0, 77.0, 344.0, 290.0 ],
		"bglocked" : 0,
		"defrect" : [ 162.0, 77.0, 344.0, 290.0 ],
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
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Open DSP Status",
					"numoutlets" : 0,
					"patching_rect" : [ 232.0, 501.0, 146.0, 23.0 ],
					"fontface" : 1,
					"fontsize" : 14.0,
					"presentation" : 1,
					"id" : "obj-31",
					"fontname" : "Arial",
					"numinlets" : 1,
					"presentation_rect" : [ 44.0, 248.0, 283.0, 23.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Print OSC Messages",
					"numoutlets" : 0,
					"patching_rect" : [ 217.0, 486.0, 146.0, 23.0 ],
					"fontface" : 1,
					"fontsize" : 14.0,
					"presentation" : 1,
					"id" : "obj-30",
					"fontname" : "Arial",
					"numinlets" : 1,
					"presentation_rect" : [ 44.0, 222.0, 283.0, 23.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numoutlets" : 1,
					"patching_rect" : [ 330.0, 203.0, 30.0, 30.0 ],
					"outlettype" : [ "bang" ],
					"presentation" : 1,
					"bgcolor" : [ 0.913725, 0.913725, 0.913725, 0.0 ],
					"id" : "obj-29",
					"numinlets" : 1,
					"presentation_rect" : [ 12.0, 244.0, 30.0, 30.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : ";\rdsp open",
					"linecount" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 330.0, 246.0, 55.0, 25.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 9.0,
					"id" : "obj-28",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s servercontrols.printosc",
					"numoutlets" : 0,
					"patching_rect" : [ 165.0, 189.0, 141.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-26",
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"numoutlets" : 1,
					"patching_rect" : [ 165.0, 161.0, 20.0, 20.0 ],
					"outlettype" : [ "int" ],
					"presentation" : 1,
					"id" : "obj-27",
					"numinlets" : 1,
					"presentation_rect" : [ 16.0, 221.0, 23.0, 23.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s serversend",
					"numoutlets" : 0,
					"patching_rect" : [ 85.0, 248.0, 79.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-25",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend /setharmonicfiltering 99",
					"numoutlets" : 1,
					"patching_rect" : [ 85.0, 223.0, 182.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-24",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"numoutlets" : 1,
					"patching_rect" : [ 85.0, 170.0, 60.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"fontsize" : 12.0,
					"id" : "obj-22",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Harmonic filtering",
					"numoutlets" : 0,
					"patching_rect" : [ 202.0, 471.0, 146.0, 23.0 ],
					"fontface" : 1,
					"fontsize" : 14.0,
					"presentation" : 1,
					"id" : "obj-21",
					"fontname" : "Arial",
					"numinlets" : 1,
					"presentation_rect" : [ 44.0, 195.0, 283.0, 23.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"numoutlets" : 1,
					"patching_rect" : [ 85.0, 197.0, 20.0, 20.0 ],
					"outlettype" : [ "int" ],
					"presentation" : 1,
					"id" : "obj-19",
					"numinlets" : 1,
					"presentation_rect" : [ 16.0, 195.0, 23.0, 23.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s serversend",
					"numoutlets" : 0,
					"patching_rect" : [ 253.0, 102.0, 79.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-16",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/dbcreate 92",
					"numoutlets" : 1,
					"patching_rect" : [ 253.0, 73.0, 77.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-17",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"numoutlets" : 3,
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"patching_rect" : [ 253.0, 37.0, 100.0, 20.0 ],
					"outlettype" : [ "", "", "int" ],
					"fontsize" : 12.0,
					"presentation" : 1,
					"text" : "______",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ],
					"textcolor" : [ 0.14902, 0.14902, 0.14902, 0.0 ],
					"bgovercolor" : [ 0.098039, 1.0, 0.0, 0.223529 ],
					"bgcolor" : [ 0.74902, 0.74902, 0.74902, 0.0 ],
					"id" : "obj-18",
					"fontname" : "Arial",
					"numinlets" : 1,
					"presentation_rect" : [ 242.0, 135.0, 81.0, 28.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.317647 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s serversend",
					"numoutlets" : 0,
					"patching_rect" : [ 140.0, 103.0, 79.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-13",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/dbimport 91",
					"numoutlets" : 1,
					"patching_rect" : [ 140.0, 74.0, 77.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-14",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"numoutlets" : 3,
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"patching_rect" : [ 140.0, 39.0, 100.0, 20.0 ],
					"outlettype" : [ "", "", "int" ],
					"fontsize" : 12.0,
					"presentation" : 1,
					"text" : "______",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ],
					"textcolor" : [ 0.14902, 0.14902, 0.14902, 0.0 ],
					"bgovercolor" : [ 0.098039, 1.0, 0.0, 0.223529 ],
					"bgcolor" : [ 0.74902, 0.74902, 0.74902, 0.0 ],
					"id" : "obj-15",
					"fontname" : "Arial",
					"numinlets" : 1,
					"presentation_rect" : [ 151.0, 135.0, 81.0, 28.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.317647 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s serversend",
					"numoutlets" : 0,
					"patching_rect" : [ 25.0, 103.0, 79.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-12",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/dbupdate 90",
					"numoutlets" : 1,
					"patching_rect" : [ 25.0, 74.0, 81.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-11",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"numoutlets" : 3,
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"patching_rect" : [ 25.0, 39.0, 100.0, 20.0 ],
					"outlettype" : [ "", "", "int" ],
					"fontsize" : 12.0,
					"presentation" : 1,
					"text" : "______",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ],
					"textcolor" : [ 0.14902, 0.14902, 0.14902, 0.0 ],
					"bgovercolor" : [ 0.098039, 1.0, 0.0, 0.223529 ],
					"bgcolor" : [ 0.74902, 0.74902, 0.74902, 0.0 ],
					"id" : "obj-8",
					"fontname" : "Arial",
					"numinlets" : 1,
					"presentation_rect" : [ 61.0, 134.0, 81.0, 28.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.317647 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"numoutlets" : 3,
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"patching_rect" : [ 347.0, 102.0, 100.0, 20.0 ],
					"outlettype" : [ "", "", "int" ],
					"fontsize" : 12.0,
					"presentation" : 1,
					"text" : "______",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ],
					"textcolor" : [ 0.14902, 0.14902, 0.14902, 0.0 ],
					"bgovercolor" : [ 0.098039, 1.0, 0.0, 0.223529 ],
					"bgcolor" : [ 0.74902, 0.74902, 0.74902, 0.0 ],
					"id" : "obj-7",
					"fontname" : "Arial",
					"numinlets" : 1,
					"presentation_rect" : [ 241.0, 101.0, 81.0, 28.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.317647 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route bang",
					"numoutlets" : 2,
					"patching_rect" : [ 294.0, 359.0, 68.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"id" : "obj-10",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numoutlets" : 1,
					"patching_rect" : [ 294.0, 312.0, 25.0, 25.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-9",
					"numinlets" : 0,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"numoutlets" : 1,
					"patching_rect" : [ 187.0, 419.0, 74.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-6",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Macinpote:/Users/Filoops/Desktop/Doctorat/Development/ato-ms/dbProcessed/",
					"linecount" : 4,
					"presentation_linecount" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 187.0, 456.0, 146.0, 71.0 ],
					"fontface" : 1,
					"fontsize" : 14.0,
					"presentation" : 1,
					"id" : "obj-5",
					"fontname" : "Arial",
					"numinlets" : 1,
					"presentation_rect" : [ 16.0, 34.0, 307.0, 39.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"numoutlets" : 1,
					"patching_rect" : [ 187.0, 364.0, 60.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"fontsize" : 12.0,
					"id" : "obj-4",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "database.root",
					"numoutlets" : 1,
					"patching_rect" : [ 187.0, 392.0, 84.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-3",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numoutlets" : 1,
					"patching_rect" : [ 454.0, 271.0, 64.0, 64.0 ],
					"outlettype" : [ "bang" ],
					"id" : "obj-1",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sprintf %s",
					"numoutlets" : 1,
					"patching_rect" : [ 454.0, 403.0, 63.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-46",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tosymbol",
					"numoutlets" : 1,
					"patching_rect" : [ 454.0, 379.0, 65.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-33",
					"fontname" : "Helvetica",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "opendialog fold",
					"numoutlets" : 2,
					"patching_rect" : [ 454.0, 353.0, 92.0, 18.0 ],
					"outlettype" : [ "", "bang" ],
					"fontsize" : 12.0,
					"id" : "obj-35",
					"fontname" : "Helvetica",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s getdbroot.setnewpath",
					"numoutlets" : 0,
					"patching_rect" : [ 454.0, 429.0, 135.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-32",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s serversend",
					"numoutlets" : 0,
					"patching_rect" : [ 20.0, 765.0, 69.0, 17.0 ],
					"fontsize" : 9.0,
					"id" : "obj-20",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "fpic",
					"varname" : "searchPanel",
					"numoutlets" : 0,
					"patching_rect" : [ 701.0, 123.0, 100.0, 50.0 ],
					"pic" : "settings.panel.png",
					"presentation" : 1,
					"id" : "obj-2",
					"numinlets" : 1,
					"presentation_rect" : [ 2.0, 1.0, 340.0, 289.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-29", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-26", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-16", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [ 303.5, 388.0, 196.5, 388.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-35", 0 ],
					"destination" : [ "obj-33", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-35", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-46", 0 ],
					"destination" : [ "obj-32", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-46", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
