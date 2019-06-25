{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 5,
			"minor" : 1,
			"revision" : 9
		}
,
		"rect" : [ 547.0, 67.0, 390.0, 169.0 ],
		"bglocked" : 0,
		"defrect" : [ 547.0, 67.0, 390.0, 169.0 ],
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
					"maxclass" : "textbutton",
					"numoutlets" : 3,
					"bgovercolor" : [ 0.098039, 1.0, 0.0, 0.223529 ],
					"id" : "obj-6",
					"patching_rect" : [ 41.0, 514.0, 100.0, 20.0 ],
					"outlettype" : [ "", "", "int" ],
					"text" : "______",
					"fontsize" : 12.0,
					"presentation" : 1,
					"bgcolor" : [ 0.74902, 0.74902, 0.74902, 0.0 ],
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.317647 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"presentation_rect" : [ 201.0, 125.0, 81.0, 28.0 ],
					"textcolor" : [ 0.14902, 0.14902, 0.14902, 0.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"numoutlets" : 3,
					"bgovercolor" : [ 0.098039, 1.0, 0.0, 0.223529 ],
					"id" : "obj-7",
					"patching_rect" : [ 332.0, 87.0, 100.0, 20.0 ],
					"outlettype" : [ "", "", "int" ],
					"text" : "______",
					"fontsize" : 12.0,
					"presentation" : 1,
					"bgcolor" : [ 0.74902, 0.74902, 0.74902, 0.0 ],
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.317647 ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"presentation_rect" : [ 289.0, 126.0, 81.0, 28.0 ],
					"textcolor" : [ 0.14902, 0.14902, 0.14902, 0.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numoutlets" : 1,
					"id" : "obj-5",
					"patching_rect" : [ 32.0, 590.0, 20.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"bgcolor" : [ 0.913725, 0.913725, 0.913725, 0.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "applyParams",
					"numoutlets" : 1,
					"id" : "obj-4",
					"patching_rect" : [ 360.0, 155.0, 81.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numoutlets" : 1,
					"id" : "obj-3",
					"patching_rect" : [ 360.0, 125.0, 20.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"bgcolor" : [ 0.913725, 0.913725, 0.913725, 0.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tosymbol",
					"numoutlets" : 1,
					"id" : "obj-51",
					"patching_rect" : [ 450.0, 124.0, 59.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "refresh",
					"numoutlets" : 1,
					"id" : "obj-1",
					"patching_rect" : [ 66.0, 15.0, 48.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "fromsymbol",
					"numoutlets" : 1,
					"id" : "obj-31",
					"patching_rect" : [ 473.0, 288.0, 73.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "fromsymbol",
					"numoutlets" : 1,
					"id" : "obj-30",
					"patching_rect" : [ 565.0, 289.0, 73.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s serversend",
					"numoutlets" : 0,
					"id" : "obj-29",
					"patching_rect" : [ 565.0, 316.0, 79.0, 20.0 ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "thispatcher",
					"numoutlets" : 2,
					"id" : "obj-27",
					"patching_rect" : [ 473.0, 316.0, 69.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend searchParameters",
					"numoutlets" : 1,
					"id" : "obj-26",
					"patching_rect" : [ 450.0, 155.0, 156.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route 44",
					"numoutlets" : 2,
					"id" : "obj-25",
					"patching_rect" : [ 450.0, 94.0, 55.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route /searchparameters",
					"numoutlets" : 2,
					"id" : "obj-24",
					"patching_rect" : [ 450.0, 65.0, 141.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r serverreceive",
					"numoutlets" : 1,
					"id" : "obj-23",
					"patching_rect" : [ 450.0, 36.0, 90.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jsui",
					"numoutlets" : 3,
					"id" : "obj-22",
					"filename" : "search.js",
					"patching_rect" : [ 450.0, 192.0, 64.0, 64.0 ],
					"outlettype" : [ "", "", "" ],
					"jsarguments" : [  ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numoutlets" : 1,
					"id" : "obj-21",
					"patching_rect" : [ -2.0, 694.0, 20.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend /getsearchparameters 44",
					"numoutlets" : 1,
					"id" : "obj-19",
					"patching_rect" : [ 47.0, 692.0, 191.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/getsearchparameters 44 0",
					"linecount" : 2,
					"numoutlets" : 1,
					"id" : "obj-11",
					"patching_rect" : [ 20.0, 726.0, 145.0, 32.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s serversend",
					"numoutlets" : 0,
					"id" : "obj-20",
					"patching_rect" : [ 20.0, 765.0, 69.0, 17.0 ],
					"fontsize" : 9.0,
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "radiogroup",
					"numoutlets" : 1,
					"id" : "obj-15",
					"patching_rect" : [ 13.0, 637.0, 18.0, 42.0 ],
					"outlettype" : [ "" ],
					"presentation" : 1,
					"bgcolor" : [ 0.419608, 0.592157, 0.65098, 0.0 ],
					"offset" : 20,
					"numinlets" : 1,
					"presentation_rect" : [ 11.0, 10.0, 18.0, 42.0 ],
					"inactivecolor" : [ 1.0, 0.0, 0.0, 1.0 ],
					"itemtype" : 0,
					"size" : 2,
					"value" : 0,
					"disabled" : [ 0, 0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Default criteria",
					"numoutlets" : 0,
					"id" : "obj-140",
					"patching_rect" : [ 364.0, 374.0, 96.0, 20.0 ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numoutlets" : 1,
					"id" : "obj-113",
					"patching_rect" : [ 71.0, 311.0, 20.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "- 1",
					"numoutlets" : 1,
					"id" : "obj-99",
					"patching_rect" : [ 247.0, 405.0, 32.5, 20.0 ],
					"outlettype" : [ "int" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend symbol",
					"numoutlets" : 1,
					"id" : "obj-98",
					"patching_rect" : [ 328.0, 472.0, 95.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "zl reg",
					"numoutlets" : 2,
					"id" : "obj-97",
					"patching_rect" : [ 252.0, 552.0, 131.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t 1",
					"numoutlets" : 1,
					"id" : "obj-96",
					"patching_rect" : [ 426.0, 527.0, 24.0, 20.0 ],
					"outlettype" : [ "int" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "zl stream",
					"numoutlets" : 2,
					"id" : "obj-95",
					"patching_rect" : [ 134.0, 600.0, 63.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b i 0",
					"numoutlets" : 3,
					"id" : "obj-94",
					"patching_rect" : [ 100.0, 371.0, 97.0, 20.0 ],
					"outlettype" : [ "bang", "int", "int" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "uzi",
					"numoutlets" : 3,
					"id" : "obj-93",
					"patching_rect" : [ 71.0, 335.0, 48.0, 20.0 ],
					"outlettype" : [ "bang", "bang", "int" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend append",
					"numoutlets" : 1,
					"id" : "obj-92",
					"patching_rect" : [ 348.0, 422.0, 98.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"numoutlets" : 3,
					"id" : "obj-91",
					"patching_rect" : [ 426.0, 501.0, 157.0, 20.0 ],
					"outlettype" : [ "int", "", "" ],
					"fontsize" : 12.0,
					"types" : [  ],
					"items" : [ "Genetic", "algorithm", ",", "Optimal", "Warping" ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b clear",
					"numoutlets" : 2,
					"id" : "obj-90",
					"patching_rect" : [ 348.0, 335.0, 97.0, 20.0 ],
					"outlettype" : [ "bang", "clear" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "Genetic algorithm, Optimal Warping",
					"numoutlets" : 1,
					"id" : "obj-88",
					"patching_rect" : [ 348.0, 396.0, 200.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"numoutlets" : 3,
					"id" : "obj-55",
					"patching_rect" : [ 189.0, 443.0, 157.0, 20.0 ],
					"outlettype" : [ "int", "", "" ],
					"fontsize" : 12.0,
					"types" : [  ],
					"items" : [ "Genetic algorithm (old)", ",", "Optimal warping" ],
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p",
					"numoutlets" : 1,
					"id" : "obj-41",
					"patching_rect" : [ 327.0, 232.0, 42.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ 25.0, 69.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"defrect" : [ 25.0, 69.0, 640.0, 480.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
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
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "set 0",
									"numoutlets" : 1,
									"id" : "obj-2",
									"patching_rect" : [ 50.0, 120.0, 37.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "b",
									"numoutlets" : 2,
									"id" : "obj-1",
									"patching_rect" : [ 50.0, 77.0, 61.5, 20.0 ],
									"outlettype" : [ "bang", "bang" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "size 1",
									"numoutlets" : 1,
									"id" : "obj-209",
									"patching_rect" : [ 93.0, 118.0, 42.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"numoutlets" : 1,
									"id" : "obj-39",
									"patching_rect" : [ 50.0, 40.0, 25.0, 25.0 ],
									"outlettype" : [ "bang" ],
									"numinlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"numoutlets" : 0,
									"id" : "obj-40",
									"patching_rect" : [ 50.0, 165.0, 25.0, 25.0 ],
									"numinlets" : 1,
									"comment" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-2", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-209", 0 ],
									"destination" : [ "obj-40", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-40", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 1 ],
									"destination" : [ "obj-209", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-39", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "thispatcher",
					"numoutlets" : 2,
					"id" : "obj-13",
					"patching_rect" : [ 19.0, 279.0, 69.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1,
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p fill_check_boxes",
					"numoutlets" : 2,
					"id" : "obj-18",
					"patching_rect" : [ 19.0, 256.0, 217.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 4,
					"hidden" : 1,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ 22.0, 143.0, 878.0, 500.0 ],
						"bglocked" : 0,
						"defrect" : [ 22.0, 143.0, 878.0, 500.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
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
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "button",
									"numoutlets" : 1,
									"id" : "obj-18",
									"patching_rect" : [ 374.0, 375.0, 20.0, 20.0 ],
									"outlettype" : [ "bang" ],
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script sendtoback searchPanel",
									"numoutlets" : 1,
									"id" : "obj-14",
									"patching_rect" : [ 374.0, 397.0, 174.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 6",
									"numoutlets" : 1,
									"id" : "obj-9",
									"patching_rect" : [ 680.0, 243.0, 32.5, 20.0 ],
									"outlettype" : [ "int" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sprintf label%d presentation_rect 21 %d 180 10",
									"numoutlets" : 1,
									"id" : "obj-6",
									"patching_rect" : [ 582.0, 318.0, 263.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend script send",
									"numoutlets" : 1,
									"id" : "obj-7",
									"patching_rect" : [ 582.0, 350.0, 116.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "* 20",
									"numoutlets" : 1,
									"id" : "obj-5",
									"patching_rect" : [ 680.0, 219.0, 32.5, 20.0 ],
									"outlettype" : [ "int" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "-1",
									"numoutlets" : 1,
									"id" : "obj-4",
									"patching_rect" : [ 733.0, 171.0, 32.5, 18.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numoutlets" : 1,
									"id" : "obj-3",
									"patching_rect" : [ 733.0, 145.0, 20.0, 20.0 ],
									"outlettype" : [ "bang" ],
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numoutlets" : 1,
									"id" : "obj-2",
									"patching_rect" : [ 680.0, 167.0, 20.0, 20.0 ],
									"outlettype" : [ "bang" ],
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "counter -1 0 50",
									"numoutlets" : 4,
									"id" : "obj-1",
									"patching_rect" : [ 680.0, 195.0, 90.0, 20.0 ],
									"outlettype" : [ "int", "", "", "int" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 5
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 2",
									"numoutlets" : 1,
									"id" : "obj-1365",
									"patching_rect" : [ 449.0, 237.0, 32.5, 20.0 ],
									"outlettype" : [ "int" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "tosymbol",
									"numoutlets" : 1,
									"id" : "obj-756",
									"patching_rect" : [ 536.0, 208.0, 59.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sprintf label%d set %s",
									"numoutlets" : 1,
									"id" : "obj-755",
									"patching_rect" : [ 426.0, 317.0, 129.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend script send",
									"numoutlets" : 1,
									"id" : "obj-754",
									"patching_rect" : [ 426.0, 349.0, 116.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "- 1",
									"numoutlets" : 1,
									"id" : "obj-449",
									"patching_rect" : [ 77.0, 281.0, 32.5, 20.0 ],
									"outlettype" : [ "int" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend script delete",
									"numoutlets" : 1,
									"id" : "obj-212",
									"patching_rect" : [ 77.0, 337.0, 123.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sprintf label%d",
									"numoutlets" : 1,
									"id" : "obj-211",
									"patching_rect" : [ 77.0, 309.0, 89.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "uzi 0",
									"numoutlets" : 3,
									"id" : "obj-210",
									"patching_rect" : [ 50.0, 253.0, 46.0, 20.0 ],
									"outlettype" : [ "bang", "bang", "int" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend script newdefault",
									"numoutlets" : 1,
									"id" : "obj-39",
									"patching_rect" : [ 215.0, 314.0, 148.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t i i i",
									"numoutlets" : 3,
									"id" : "obj-37",
									"patching_rect" : [ 337.0, 178.0, 131.0, 20.0 ],
									"outlettype" : [ "int", "int", "int" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sprintf label%d 16 %d comment @fontsize 12 @textcolor 1 1 1 1 @presentation 1 @presentation_position 20 %d @presentation_rect 16 %d 10 %d",
									"linecount" : 2,
									"numoutlets" : 1,
									"id" : "obj-35",
									"patching_rect" : [ 215.0, 269.0, 595.0, 34.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 5
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "* 20",
									"numoutlets" : 1,
									"id" : "obj-34",
									"patching_rect" : [ 449.0, 212.0, 32.5, 20.0 ],
									"outlettype" : [ "int" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl slice 1",
									"numoutlets" : 2,
									"id" : "obj-33",
									"patching_rect" : [ 337.0, 134.0, 57.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"numoutlets" : 1,
									"id" : "obj-32",
									"patching_rect" : [ 337.0, 100.0, 58.0, 20.0 ],
									"outlettype" : [ "list" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "size $1",
									"numoutlets" : 1,
									"id" : "obj-15",
									"patching_rect" : [ 252.0, 103.0, 49.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontsize" : 12.0,
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"numoutlets" : 1,
									"id" : "obj-8",
									"patching_rect" : [ 50.0, 40.0, 25.0, 25.0 ],
									"outlettype" : [ "bang" ],
									"numinlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"numoutlets" : 1,
									"id" : "obj-10",
									"patching_rect" : [ 77.0, 40.0, 25.0, 25.0 ],
									"outlettype" : [ "" ],
									"numinlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"numoutlets" : 1,
									"id" : "obj-12",
									"patching_rect" : [ 252.0, 40.0, 25.0, 25.0 ],
									"outlettype" : [ "int" ],
									"numinlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"numoutlets" : 1,
									"id" : "obj-13",
									"patching_rect" : [ 337.0, 40.0, 25.0, 25.0 ],
									"outlettype" : [ "" ],
									"numinlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"numoutlets" : 0,
									"id" : "obj-16",
									"patching_rect" : [ 215.333313, 430.0, 25.0, 25.0 ],
									"numinlets" : 1,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"numoutlets" : 0,
									"id" : "obj-17",
									"patching_rect" : [ 252.0, 429.0, 25.0, 25.0 ],
									"numinlets" : 1,
									"comment" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-14", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 0 ],
									"destination" : [ "obj-18", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-18", 0 ],
									"destination" : [ "obj-14", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [ 59.5, 127.5, 742.5, 127.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-33", 0 ],
									"destination" : [ "obj-2", 0 ],
									"hidden" : 0,
									"midpoints" : [ 346.5, 161.0, 689.5, 161.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-755", 0 ],
									"destination" : [ "obj-754", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 0 ],
									"destination" : [ "obj-755", 0 ],
									"hidden" : 0,
									"midpoints" : [ 346.5, 249.0, 435.5, 249.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-33", 0 ],
									"destination" : [ "obj-37", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-756", 0 ],
									"destination" : [ "obj-755", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-33", 1 ],
									"destination" : [ "obj-756", 0 ],
									"hidden" : 0,
									"midpoints" : [ 384.5, 167.5, 545.5, 167.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-210", 2 ],
									"destination" : [ "obj-449", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-449", 0 ],
									"destination" : [ "obj-211", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-211", 0 ],
									"destination" : [ "obj-212", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-32", 0 ],
									"destination" : [ "obj-33", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-210", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-210", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-12", 0 ],
									"destination" : [ "obj-15", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-13", 0 ],
									"destination" : [ "obj-32", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-212", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-39", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-754", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-15", 0 ],
									"destination" : [ "obj-17", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 2 ],
									"destination" : [ "obj-34", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-34", 0 ],
									"destination" : [ "obj-1365", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-1", 3 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1365", 0 ],
									"destination" : [ "obj-35", 3 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1365", 0 ],
									"destination" : [ "obj-35", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 1 ],
									"destination" : [ "obj-35", 0 ],
									"hidden" : 0,
									"midpoints" : [ 402.5, 227.5, 224.5, 227.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-35", 0 ],
									"destination" : [ "obj-39", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-35", 4 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-35", 2 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-6", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numoutlets" : 1,
					"id" : "obj-28",
					"patching_rect" : [ 19.0, 13.0, 25.0, 25.0 ],
					"outlettype" : [ "" ],
					"numinlets" : 0,
					"hidden" : 1,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route refresh apply",
					"numoutlets" : 3,
					"id" : "obj-2224",
					"patching_rect" : [ 19.0, 49.0, 111.0, 20.0 ],
					"outlettype" : [ "", "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t i i zlclear",
					"numoutlets" : 3,
					"id" : "obj-1990",
					"patching_rect" : [ 251.0, 222.0, 64.0, 20.0 ],
					"outlettype" : [ "int", "int", "zlclear" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "b",
					"numoutlets" : 2,
					"id" : "obj-833",
					"patching_rect" : [ 19.0, 108.0, 133.5, 20.0 ],
					"outlettype" : [ "bang", "bang" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "zl len",
					"numoutlets" : 2,
					"id" : "obj-14",
					"patching_rect" : [ 85.0, 188.0, 39.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 2,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "search.getalgorithms",
					"numoutlets" : 3,
					"id" : "obj-9",
					"patching_rect" : [ 19.0, 136.0, 122.0, 20.0 ],
					"outlettype" : [ "", "", "" ],
					"fontsize" : 12.0,
					"fontname" : "Arial",
					"numinlets" : 1,
					"hidden" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "fpic",
					"varname" : "searchPanel",
					"numoutlets" : 0,
					"id" : "obj-2",
					"patching_rect" : [ 701.0, 123.0, 100.0, 50.0 ],
					"pic" : "search.panel.png",
					"presentation" : 1,
					"numinlets" : 1,
					"presentation_rect" : [ 2.0, 1.0, 386.0, 164.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 1 ],
					"destination" : [ "obj-31", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-95", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 369.5, 184.0, 459.5, 184.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-2224", 0 ],
					"hidden" : 0,
					"midpoints" : [ 75.5, 41.5, 28.5, 41.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-31", 0 ],
					"destination" : [ "obj-27", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 0 ],
					"destination" : [ "obj-29", 0 ],
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
, 			{
				"patchline" : 				{
					"source" : [ "obj-23", 0 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [ 22.5, 685.0, 56.5, 685.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-11", 1 ],
					"hidden" : 0,
					"midpoints" : [ 56.5, 718.5, 155.5, 718.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-1990", 0 ],
					"hidden" : 1,
					"midpoints" : [ 94.5, 217.0, 260.5, 217.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-41", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 1,
					"midpoints" : [ 336.5, 435.0, 22.5, 435.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-28", 0 ],
					"destination" : [ "obj-2224", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-97", 0 ],
					"destination" : [ "obj-95", 0 ],
					"hidden" : 1,
					"midpoints" : [ 261.5, 584.0, 143.5, 584.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-113", 0 ],
					"destination" : [ "obj-93", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-94", 0 ],
					"destination" : [ "obj-97", 0 ],
					"hidden" : 1,
					"midpoints" : [ 109.5, 544.5, 261.5, 544.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-96", 0 ],
					"destination" : [ "obj-97", 1 ],
					"hidden" : 1,
					"midpoints" : [ 435.5, 549.0, 373.5, 549.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 0 ],
					"destination" : [ "obj-96", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-99", 0 ],
					"destination" : [ "obj-55", 0 ],
					"hidden" : 1,
					"midpoints" : [ 256.5, 435.5, 198.5, 435.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-94", 1 ],
					"destination" : [ "obj-99", 0 ],
					"hidden" : 1,
					"midpoints" : [ 148.5, 399.0, 256.5, 399.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-55", 1 ],
					"destination" : [ "obj-98", 0 ],
					"hidden" : 1,
					"midpoints" : [ 267.5, 467.0, 337.5, 467.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1990", 1 ],
					"destination" : [ "obj-93", 1 ],
					"hidden" : 1,
					"midpoints" : [ 283.0, 311.0, 109.5, 311.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-98", 0 ],
					"destination" : [ "obj-91", 0 ],
					"hidden" : 1,
					"midpoints" : [ 337.5, 496.0, 435.5, 496.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-94", 2 ],
					"destination" : [ "obj-97", 1 ],
					"hidden" : 1,
					"midpoints" : [ 187.5, 540.5, 373.5, 540.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-93", 2 ],
					"destination" : [ "obj-94", 0 ],
					"hidden" : 1,
					"midpoints" : [ 109.5, 366.0, 109.5, 366.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1990", 1 ],
					"destination" : [ "obj-95", 1 ],
					"hidden" : 1,
					"midpoints" : [ 283.0, 435.5, 187.5, 435.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1990", 2 ],
					"destination" : [ "obj-95", 0 ],
					"hidden" : 1,
					"midpoints" : [ 305.5, 435.5, 143.5, 435.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1990", 1 ],
					"destination" : [ "obj-18", 2 ],
					"hidden" : 1,
					"midpoints" : [ 283.0, 249.0, 160.5, 249.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-90", 1 ],
					"destination" : [ "obj-91", 0 ],
					"hidden" : 1,
					"midpoints" : [ 435.5, 493.5, 435.5, 493.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-88", 0 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-92", 0 ],
					"destination" : [ "obj-91", 0 ],
					"hidden" : 1,
					"midpoints" : [ 357.5, 450.0, 435.5, 450.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-90", 0 ],
					"destination" : [ "obj-88", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-833", 1 ],
					"destination" : [ "obj-41", 0 ],
					"hidden" : 1,
					"midpoints" : [ 143.0, 177.5, 336.5, 177.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-833", 1 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 1,
					"midpoints" : [ 143.0, 164.5, 28.5, 164.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-18", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 1 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 1,
					"midpoints" : [ 226.5, 435.5, 22.5, 435.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 2 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 1,
					"midpoints" : [ 131.5, 178.5, 94.5, 178.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-833", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 1,
					"midpoints" : [ 28.5, 131.0, 28.5, 131.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 2 ],
					"destination" : [ "obj-18", 3 ],
					"hidden" : 1,
					"midpoints" : [ 131.5, 249.0, 226.5, 249.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-55", 0 ],
					"hidden" : 1,
					"midpoints" : [ 28.5, 435.5, 198.5, 435.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 1 ],
					"destination" : [ "obj-113", 0 ],
					"hidden" : 1,
					"midpoints" : [ 80.0, 305.0, 80.5, 305.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-26", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-51", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-51", 0 ],
					"destination" : [ "obj-26", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-93", 1 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2224", 0 ],
					"destination" : [ "obj-833", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
