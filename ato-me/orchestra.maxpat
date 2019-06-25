{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 5,
			"minor" : 1,
			"revision" : 9
		}
,
		"rect" : [ 63.0, 44.0, 348.0, 642.0 ],
		"bglocked" : 0,
		"defrect" : [ 63.0, 44.0, 348.0, 642.0 ],
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
					"maxclass" : "textbutton",
					"presentation_rect" : [ 10.0, 606.0, 62.0, 26.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 3,
					"text" : "______",
					"patching_rect" : [ 926.0, 57.0, 61.0, 22.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ],
					"outlettype" : [ "", "", "int" ],
					"presentation" : 1,
					"textcolor" : [ 0.0, 0.0, 0.0, 0.0 ],
					"bgovercolor" : [ 0.2, 1.0, 0.0, 0.231373 ],
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"id" : "obj-46",
					"bgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"fontname" : "Arial",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.352941 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"presentation_rect" : [ 224.0, 30.0, 49.0, 21.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 3,
					"text" : "______",
					"patching_rect" : [ 594.0, 162.0, 61.0, 22.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ],
					"outlettype" : [ "", "", "int" ],
					"presentation" : 1,
					"textcolor" : [ 0.0, 0.0, 0.0, 0.0 ],
					"bgovercolor" : [ 0.2, 1.0, 0.0, 0.231373 ],
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"id" : "obj-42",
					"bgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"fontname" : "Arial",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.352941 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"presentation_rect" : [ 207.0, 606.0, 62.0, 26.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 3,
					"text" : "______",
					"patching_rect" : [ 692.0, 581.0, 61.0, 22.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ],
					"outlettype" : [ "", "", "int" ],
					"presentation" : 1,
					"textcolor" : [ 0.0, 0.0, 0.0, 0.0 ],
					"bgovercolor" : [ 0.2, 1.0, 0.0, 0.231373 ],
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"id" : "obj-10",
					"bgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"fontname" : "Arial",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.352941 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend addInstrument",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 867.0, 198.0, 135.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-35",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route 372",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 867.0, 176.0, 61.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"id" : "obj-34",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route /allowedinstrument",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 867.0, 154.0, 141.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"id" : "obj-31",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numoutlets" : 1,
					"patching_rect" : [ 957.0, 245.0, 20.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"id" : "obj-30",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route /clearorchestra",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 957.0, 222.0, 121.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"id" : "obj-28",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r serverreceive",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 957.0, 108.0, 90.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-24",
					"fontname" : "Arial",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend loadOrchestra",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 580.0, 228.0, 133.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-23",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "opendialog",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 580.0, 201.0, 69.0, 20.0 ],
					"outlettype" : [ "", "bang" ],
					"id" : "obj-22",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend saveOrchestraTo",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 365.0, 148.0, 149.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-20",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "savedialog .orchestra",
					"linecount" : 2,
					"fontsize" : 12.0,
					"numoutlets" : 3,
					"patching_rect" : [ 365.0, 103.0, 71.0, 34.0 ],
					"outlettype" : [ "", "", "bang" ],
					"id" : "obj-19",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s setorchestra",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 453.0, 218.0, 86.0, 20.0 ],
					"id" : "obj-15",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "saveOrchestra",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 467.0, 170.0, 89.0, 18.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-16",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"presentation_rect" : [ 278.0, 29.0, 53.0, 23.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 3,
					"text" : "_____",
					"patching_rect" : [ 441.0, 77.0, 61.0, 22.0 ],
					"textovercolor" : [ 1.0, 1.0, 0.0, 1.0 ],
					"outlettype" : [ "", "", "int" ],
					"presentation" : 1,
					"textcolor" : [ 0.14902, 0.14902, 0.14902, 0.0 ],
					"bgovercolor" : [ 0.0, 1.0, 0.05098, 0.231373 ],
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"id" : "obj-18",
					"bgcolor" : [ 0.74902, 0.74902, 0.74902, 0.0 ],
					"fontname" : "Arial",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.345098 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s orchestra.window.close",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 688.0, 619.0, 144.0, 20.0 ],
					"id" : "obj-8",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s setorchestra",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 359.0, 49.0, 86.0, 20.0 ],
					"id" : "obj-7",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "print orch",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 459.0, 542.0, 61.0, 20.0 ],
					"id" : "obj-6",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"varname" : "slot4",
					"presentation_rect" : [ 248.0, 56.0, 59.0, 19.0 ],
					"fontsize" : 11.0,
					"bgcolor2" : [ 0.917647, 0.917647, 0.917647, 1.0 ],
					"numoutlets" : 3,
					"textcolor2" : [ 0.0, 0.0, 0.0, 1.0 ],
					"items" : [ "<>", ",", "<separator>", ",", "Picc", ",", "Fl", ",", "BFl", ",", "CbFl", ",", "<separator>", ",", "Ob", ",", "EH", ",", "<separator>", ",", "ClEb", ",", "ClBb", ",", "BClBb", ",", "CbClBb", ",", "<separator>", ",", "Bn", ",", "<separator>", ",", "ASax", ",", "<separator>", ",", "Hn", ",", "<separator>", ",", "Va", ",", "Cb" ],
					"types" : [  ],
					"patching_rect" : [ 816.0, 53.0, 51.0, 19.0 ],
					"outlettype" : [ "int", "", "" ],
					"presentation" : 1,
					"pattrmode" : 1,
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-43",
					"bgcolor" : [ 0.47451, 0.533333, 0.564706, 1.0 ],
					"framecolor" : [ 0.015686, 0.015686, 0.015686, 1.0 ],
					"fontname" : "Arial",
					"hltcolor" : [ 0.917647, 0.894118, 0.835294, 1.0 ],
					"arrow" : 0,
					"discolor" : [ 0.439216, 0.439216, 0.439216, 1.0 ],
					"togcolor" : [ 0.552941, 0.552941, 0.552941, 1.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"varname" : "slot3",
					"presentation_rect" : [ 187.0, 56.0, 59.0, 19.0 ],
					"fontsize" : 11.0,
					"bgcolor2" : [ 0.917647, 0.917647, 0.917647, 1.0 ],
					"numoutlets" : 3,
					"textcolor2" : [ 0.0, 0.0, 0.0, 1.0 ],
					"items" : [ "<>", ",", "<separator>", ",", "Picc", ",", "Fl", ",", "BFl", ",", "CbFl", ",", "<separator>", ",", "Ob", ",", "EH", ",", "<separator>", ",", "ClEb", ",", "ClBb", ",", "BClBb", ",", "CbClBb", ",", "<separator>", ",", "Bn", ",", "<separator>", ",", "ASax", ",", "<separator>", ",", "Hn", ",", "<separator>", ",", "Va", ",", "Cb" ],
					"types" : [  ],
					"patching_rect" : [ 760.0, 53.0, 51.0, 19.0 ],
					"outlettype" : [ "int", "", "" ],
					"presentation" : 1,
					"pattrmode" : 1,
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-44",
					"bgcolor" : [ 0.360784, 0.403922, 0.423529, 1.0 ],
					"framecolor" : [ 0.015686, 0.015686, 0.015686, 1.0 ],
					"fontname" : "Arial",
					"hltcolor" : [ 0.847059, 0.788235, 0.705882, 1.0 ],
					"arrow" : 0,
					"discolor" : [ 0.439216, 0.439216, 0.439216, 1.0 ],
					"togcolor" : [ 0.552941, 0.552941, 0.552941, 1.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"varname" : "slot2[1]",
					"presentation_rect" : [ 126.0, 56.0, 59.0, 19.0 ],
					"fontsize" : 11.0,
					"bgcolor2" : [ 0.917647, 0.917647, 0.917647, 1.0 ],
					"numoutlets" : 3,
					"textcolor2" : [ 0.0, 0.0, 0.0, 1.0 ],
					"items" : [ "<>", ",", "<separator>", ",", "Picc", ",", "Fl", ",", "BFl", ",", "CbFl", ",", "<separator>", ",", "Ob", ",", "EH", ",", "<separator>", ",", "ClEb", ",", "ClBb", ",", "BClBb", ",", "CbClBb", ",", "<separator>", ",", "Bn", ",", "<separator>", ",", "ASax", ",", "<separator>", ",", "Hn", ",", "<separator>", ",", "Va", ",", "Cb" ],
					"types" : [  ],
					"patching_rect" : [ 704.0, 53.0, 51.0, 19.0 ],
					"outlettype" : [ "int", "", "" ],
					"presentation" : 1,
					"pattrmode" : 1,
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-4",
					"bgcolor" : [ 0.243137, 0.305882, 0.333333, 1.0 ],
					"framecolor" : [ 0.015686, 0.015686, 0.015686, 1.0 ],
					"fontname" : "Arial",
					"hltcolor" : [ 0.803922, 0.709804, 0.619608, 1.0 ],
					"arrow" : 0,
					"discolor" : [ 0.439216, 0.439216, 0.439216, 1.0 ],
					"togcolor" : [ 0.552941, 0.552941, 0.552941, 1.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "clearOrchestra",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 926.0, 271.0, 89.0, 18.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-3",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 548.0, 108.0, 50.0, 18.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-2",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tosymbol",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 800.0, 98.0, 59.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-1",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend instrumentList",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 800.0, 123.0, 133.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-41",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r orchestra.instlist",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 873.0, 14.0, 105.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-40",
					"fontname" : "Arial",
					"numinlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sprintf %d %d %d %d %d",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 579.0, 85.0, 206.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-39",
					"fontname" : "Arial",
					"numinlets" : 5
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"varname" : "slot2",
					"presentation_rect" : [ 67.0, 56.0, 57.0, 19.0 ],
					"fontsize" : 11.0,
					"bgcolor2" : [ 0.917647, 0.917647, 0.917647, 1.0 ],
					"numoutlets" : 3,
					"textcolor2" : [ 0.0, 0.0, 0.0, 1.0 ],
					"items" : [ "<>", ",", "<separator>", ",", "Picc", ",", "Fl", ",", "BFl", ",", "CbFl", ",", "<separator>", ",", "Ob", ",", "EH", ",", "<separator>", ",", "ClEb", ",", "ClBb", ",", "BClBb", ",", "CbClBb", ",", "<separator>", ",", "Bn", ",", "<separator>", ",", "ASax", ",", "<separator>", ",", "Hn", ",", "<separator>", ",", "Va", ",", "Cb" ],
					"types" : [  ],
					"patching_rect" : [ 645.0, 53.0, 51.0, 19.0 ],
					"outlettype" : [ "int", "", "" ],
					"presentation" : 1,
					"pattrmode" : 1,
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-45",
					"bgcolor" : [ 0.243137, 0.305882, 0.333333, 1.0 ],
					"framecolor" : [ 0.015686, 0.015686, 0.015686, 1.0 ],
					"fontname" : "Arial",
					"hltcolor" : [ 0.803922, 0.709804, 0.619608, 1.0 ],
					"arrow" : 0,
					"discolor" : [ 0.439216, 0.439216, 0.439216, 1.0 ],
					"togcolor" : [ 0.552941, 0.552941, 0.552941, 1.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend addElements",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 548.0, 129.0, 128.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-38",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"presentation_rect" : [ 305.0, 55.0, 33.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 579.0, 52.0, 56.0, 20.0 ],
					"outlettype" : [ "int", "bang" ],
					"presentation" : 1,
					"textcolor" : [ 1.0, 0.701961, 0.0, 1.0 ],
					"bordercolor" : [ 0.501961, 0.501961, 0.501961, 0.0 ],
					"id" : "obj-37",
					"bgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"presentation_rect" : [ 11.0, 54.0, 53.0, 22.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 3,
					"text" : "_____",
					"patching_rect" : [ 548.0, 18.0, 54.0, 20.0 ],
					"textovercolor" : [ 1.0, 1.0, 0.0, 1.0 ],
					"outlettype" : [ "", "", "int" ],
					"presentation" : 1,
					"rounded" : 8.0,
					"textcolor" : [ 0.14902, 0.14902, 0.14902, 0.0 ],
					"bgovercolor" : [ 0.05098, 1.0, 0.0, 0.231373 ],
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"id" : "obj-36",
					"bgcolor" : [ 0.74902, 0.74902, 0.74902, 0.0 ],
					"fontname" : "Arial",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.345098 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "setOrchestra",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 455.0, 51.0, 79.0, 18.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-33",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s orchestra.resolution",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 919.0, 394.0, 125.0, 20.0 ],
					"id" : "obj-87",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"varname" : "resolution[2]",
					"arrowlink" : 0,
					"fontsize" : 12.0,
					"arrowframe" : 0,
					"bgcolor2" : [ 0.917647, 0.917647, 0.917647, 1.0 ],
					"numoutlets" : 3,
					"textcolor2" : [ 0.121569, 0.121569, 0.121569, 1.0 ],
					"items" : [ 1, ",", 2, ",", 4, ",", 8 ],
					"types" : [  ],
					"patching_rect" : [ 892.0, 365.0, 73.0, 20.0 ],
					"outlettype" : [ "int", "", "" ],
					"pattrmode" : 1,
					"textcolor" : [ 0.121569, 0.121569, 0.121569, 1.0 ],
					"id" : "obj-85",
					"framecolor" : [ 0.647059, 0.647059, 0.647059, 1.0 ],
					"fontname" : "Arial",
					"hltcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"discolor" : [ 0.439216, 0.439216, 0.439216, 1.0 ],
					"hidden" : 1,
					"togcolor" : [ 0.552941, 0.552941, 0.552941, 1.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t 1",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 822.0, 309.0, 30.0, 20.0 ],
					"outlettype" : [ "int" ],
					"id" : "obj-17",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "readybang 601",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 822.0, 283.0, 91.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"id" : "obj-14",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "b",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 784.0, 257.0, 56.5, 20.0 ],
					"outlettype" : [ "bang", "bang" ],
					"id" : "obj-13",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route refresh",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 784.0, 203.0, 79.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"id" : "obj-12",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numoutlets" : 1,
					"patching_rect" : [ 784.0, 170.0, 25.0, 25.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-9",
					"hidden" : 1,
					"numinlets" : 0,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textbutton",
					"presentation_rect" : [ 274.0, 606.0, 62.0, 26.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 3,
					"text" : "______",
					"patching_rect" : [ 439.0, 16.0, 61.0, 22.0 ],
					"textovercolor" : [ 0.94902, 1.0, 0.0, 1.0 ],
					"outlettype" : [ "", "", "int" ],
					"presentation" : 1,
					"textcolor" : [ 0.0, 0.0, 0.0, 0.0 ],
					"bgovercolor" : [ 0.2, 1.0, 0.0, 0.231373 ],
					"bordercolor" : [ 0.6, 0.6, 0.6, 0.0 ],
					"id" : "obj-11",
					"bgcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"fontname" : "Arial",
					"borderoncolor" : [ 0.4, 0.4, 0.4, 0.0 ],
					"bgoncolor" : [ 1.0, 0.0, 0.0, 0.352941 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tosymbol",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 439.0, 568.0, 65.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-25",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s serversend",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 439.0, 621.0, 89.0, 20.0 ],
					"id" : "obj-26",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sprintf /setorchestra 603 %s",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 439.0, 595.0, 159.0, 20.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-27",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jsui",
					"numoutlets" : 1,
					"filename" : "jsui_textbutton.js",
					"patching_rect" : [ 784.0, 228.0, 66.0, 22.0 ],
					"outlettype" : [ "" ],
					"jsarguments" : [ "Refresh" ],
					"id" : "obj-29",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "bpatcher",
					"varname" : "orchestra.group.pat[1]",
					"presentation_rect" : [ 7.0, 79.0, 332.0, 521.0 ],
					"lockeddragscroll" : 1,
					"numoutlets" : 1,
					"args" : [  ],
					"patching_rect" : [ 439.0, 324.0, 321.0, 187.0 ],
					"outlettype" : [ "" ],
					"presentation" : 1,
					"name" : "orchestra.group.maxpat",
					"id" : "obj-49",
					"enablevscroll" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "expr pow(2\\, $i1)",
					"fontsize" : 9.0,
					"numoutlets" : 1,
					"patching_rect" : [ 822.0, 426.0, 94.0, 17.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-51",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadmess set 0",
					"fontsize" : 9.0,
					"numoutlets" : 1,
					"patching_rect" : [ 822.0, 338.0, 71.0, 17.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-52",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend /setresolution 602",
					"fontsize" : 9.0,
					"numoutlets" : 1,
					"patching_rect" : [ 822.0, 449.0, 134.0, 17.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-53",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"varname" : "resolution",
					"arrowlink" : 0,
					"fontsize" : 12.0,
					"arrowframe" : 0,
					"bgcolor2" : [ 0.917647, 0.917647, 0.917647, 1.0 ],
					"numoutlets" : 3,
					"textcolor2" : [ 0.121569, 0.121569, 0.121569, 1.0 ],
					"items" : [ "1/2", "tone", ",", "1/4", "tone", ",", "1/8", "tone", ",", "1/16", "tone" ],
					"types" : [  ],
					"patching_rect" : [ 822.0, 394.0, 85.0, 20.0 ],
					"outlettype" : [ "int", "", "" ],
					"pattrmode" : 1,
					"textcolor" : [ 0.121569, 0.121569, 0.121569, 1.0 ],
					"id" : "obj-54",
					"framecolor" : [ 0.647059, 0.647059, 0.647059, 1.0 ],
					"fontname" : "Arial",
					"hltcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"discolor" : [ 0.439216, 0.439216, 0.439216, 1.0 ],
					"togcolor" : [ 0.552941, 0.552941, 0.552941, 1.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s orchestra.instlist",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 784.0, 524.0, 126.0, 20.0 ],
					"id" : "obj-71",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p getinstlist",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 784.0, 497.0, 82.0, 20.0 ],
					"outlettype" : [ "clear", "" ],
					"id" : "obj-73",
					"fontname" : "Arial",
					"hidden" : 1,
					"numinlets" : 1,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ 236.0, 44.0, 836.0, 752.0 ],
						"bglocked" : 0,
						"defrect" : [ 236.0, 44.0, 836.0, 752.0 ],
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
									"maxclass" : "newobj",
									"text" : "t l l",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 44.0, 334.0, 32.5, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-51",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"numoutlets" : 0,
									"patching_rect" : [ 291.0, 633.0, 28.0, 28.0 ],
									"id" : "obj-50",
									"numinlets" : 1,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t 0",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 58.0, 540.0, 25.0, 20.0 ],
									"outlettype" : [ "int" ],
									"id" : "obj-21",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "append <>",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 213.0, 540.0, 69.0, 18.0 ],
									"outlettype" : [ "" ],
									"id" : "obj-23",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend append",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 109.0, 539.0, 102.0, 20.0 ],
									"outlettype" : [ "" ],
									"id" : "obj-26",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "route 1",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 58.0, 509.0, 54.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-29",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t l l b clear",
									"fontsize" : 12.0,
									"numoutlets" : 4,
									"patching_rect" : [ 58.0, 391.0, 252.0, 20.0 ],
									"outlettype" : [ "", "", "bang", "clear" ],
									"id" : "obj-30",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "== 0",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 58.0, 485.0, 97.0, 20.0 ],
									"outlettype" : [ "int" ],
									"id" : "obj-32",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack i s",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 58.0, 452.0, 70.0, 20.0 ],
									"outlettype" : [ "int", "" ],
									"id" : "obj-34",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "- 1",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 136.0, 453.0, 42.0, 20.0 ],
									"outlettype" : [ "int" ],
									"id" : "obj-36",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 58.0, 428.0, 67.0, 20.0 ],
									"outlettype" : [ "list" ],
									"id" : "obj-37",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl len",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 136.0, 428.0, 42.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-39",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend <separator>",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 44.0, 300.0, 123.0, 20.0 ],
									"outlettype" : [ "" ],
									"id" : "obj-41",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "regexp - @substitute <separator>",
									"fontsize" : 12.0,
									"numoutlets" : 5,
									"patching_rect" : [ 44.0, 273.0, 189.0, 20.0 ],
									"outlettype" : [ "", "", "", "", "" ],
									"id" : "obj-42",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "route 601",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 44.0, 237.0, 61.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-47",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "route /dbscoreorder",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 44.0, 209.0, 115.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-48",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r serverreceive",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 44.0, 183.0, 90.0, 20.0 ],
									"outlettype" : [ "" ],
									"id" : "obj-49",
									"fontname" : "Arial",
									"numinlets" : 0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"numoutlets" : 0,
									"patching_rect" : [ 503.0, 653.0, 28.0, 28.0 ],
									"id" : "obj-45",
									"numinlets" : 1,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend <>",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 441.0, 386.0, 72.0, 20.0 ],
									"outlettype" : [ "" ],
									"id" : "obj-44",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 504.0, 556.0, 49.0, 20.0 ],
									"outlettype" : [ "int", "int" ],
									"id" : "obj-40",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl group 32",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 503.0, 609.0, 70.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-38",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "- 0",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 554.0, 498.0, 48.5, 20.0 ],
									"outlettype" : [ "int" ],
									"id" : "obj-35",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl len",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 673.0, 471.0, 39.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-33",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "regexp <separator>",
									"fontsize" : 12.0,
									"numoutlets" : 5,
									"patching_rect" : [ 625.0, 446.0, 115.0, 20.0 ],
									"outlettype" : [ "", "", "", "", "" ],
									"id" : "obj-31",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl len",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 554.0, 470.0, 39.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-28",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t l l l",
									"fontsize" : 12.0,
									"numoutlets" : 3,
									"patching_rect" : [ 442.0, 420.0, 202.0, 20.0 ],
									"outlettype" : [ "", "", "" ],
									"id" : "obj-27",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "route <separator>",
									"linecount" : 2,
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 442.0, 512.0, 81.0, 34.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-25",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl rev",
									"fontsize" : 12.0,
									"numoutlets" : 2,
									"patching_rect" : [ 442.0, 483.0, 58.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"id" : "obj-24",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 442.0, 455.0, 58.0, 20.0 ],
									"outlettype" : [ "list" ],
									"id" : "obj-22",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"numoutlets" : 1,
									"patching_rect" : [ 48.0, 49.0, 23.0, 23.0 ],
									"outlettype" : [ "bang" ],
									"id" : "obj-1",
									"numinlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s serversend",
									"fontsize" : 12.0,
									"numoutlets" : 0,
									"patching_rect" : [ 48.0, 114.0, 89.0, 20.0 ],
									"id" : "obj-18",
									"fontname" : "Arial",
									"numinlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "/dbgetscoreorder 601",
									"fontsize" : 12.0,
									"numoutlets" : 1,
									"patching_rect" : [ 48.0, 88.0, 125.0, 18.0 ],
									"outlettype" : [ "" ],
									"id" : "obj-19",
									"fontname" : "Arial",
									"numinlets" : 2
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-40", 1 ],
									"destination" : [ "obj-38", 0 ],
									"hidden" : 0,
									"midpoints" : [ 543.5, 602.5, 512.5, 602.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-38", 0 ],
									"destination" : [ "obj-45", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 1 ],
									"destination" : [ "obj-40", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-35", 0 ],
									"destination" : [ "obj-38", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-33", 0 ],
									"destination" : [ "obj-35", 1 ],
									"hidden" : 0,
									"midpoints" : [ 682.5, 494.0, 593.0, 494.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-27", 2 ],
									"destination" : [ "obj-31", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-28", 0 ],
									"destination" : [ "obj-35", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-27", 0 ],
									"destination" : [ "obj-22", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-27", 1 ],
									"destination" : [ "obj-28", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-31", 2 ],
									"destination" : [ "obj-33", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-24", 0 ],
									"destination" : [ "obj-25", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-22", 0 ],
									"destination" : [ "obj-24", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-19", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-19", 0 ],
									"destination" : [ "obj-18", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-29", 0 ],
									"destination" : [ "obj-21", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 1 ],
									"destination" : [ "obj-39", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-39", 0 ],
									"destination" : [ "obj-36", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-34", 0 ],
									"destination" : [ "obj-32", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-32", 0 ],
									"destination" : [ "obj-29", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-36", 0 ],
									"destination" : [ "obj-32", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 0 ],
									"destination" : [ "obj-37", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 0 ],
									"destination" : [ "obj-34", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-34", 1 ],
									"destination" : [ "obj-26", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 2 ],
									"destination" : [ "obj-23", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-42", 0 ],
									"destination" : [ "obj-41", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-49", 0 ],
									"destination" : [ "obj-48", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 3 ],
									"destination" : [ "obj-50", 0 ],
									"hidden" : 0,
									"midpoints" : [ 300.5, 521.5, 300.5, 521.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-23", 0 ],
									"destination" : [ "obj-50", 0 ],
									"hidden" : 0,
									"midpoints" : [ 222.5, 595.0, 300.5, 595.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-26", 0 ],
									"destination" : [ "obj-50", 0 ],
									"hidden" : 0,
									"midpoints" : [ 118.5, 595.5, 300.5, 595.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-21", 0 ],
									"destination" : [ "obj-50", 0 ],
									"hidden" : 0,
									"midpoints" : [ 67.5, 595.0, 300.5, 595.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-41", 0 ],
									"destination" : [ "obj-51", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-51", 1 ],
									"destination" : [ "obj-30", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-44", 0 ],
									"destination" : [ "obj-27", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-51", 0 ],
									"destination" : [ "obj-44", 0 ],
									"hidden" : 0,
									"midpoints" : [ 53.5, 369.5, 450.5, 369.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-48", 0 ],
									"destination" : [ "obj-47", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-47", 0 ],
									"destination" : [ "obj-42", 0 ],
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
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0,
						"globalpatchername" : ""
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "fpic",
					"presentation_rect" : [ 0.0, 0.0, 345.0, 642.0 ],
					"numoutlets" : 0,
					"patching_rect" : [ 7.0, 12.0, 346.0, 607.0 ],
					"pic" : "orchestra.panel.png",
					"presentation" : 1,
					"id" : "obj-32",
					"numinlets" : 1
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [ 448.5, 72.0, 426.0, 72.0, 426.0, 90.0, 360.0, 90.0, 360.0, 180.0, 426.0, 180.0, 426.0, 528.0, 675.0, 528.0, 675.0, 615.0, 697.5, 615.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-46", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-42", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-35", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [ 876.5, 279.0, 448.5, 279.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-34", 0 ],
					"destination" : [ "obj-35", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-31", 0 ],
					"destination" : [ "obj-34", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-31", 0 ],
					"hidden" : 0,
					"midpoints" : [ 966.5, 147.5, 876.5, 147.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [ 966.5, 267.0, 935.5, 267.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-28", 0 ],
					"destination" : [ "obj-30", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-23", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-33", 0 ],
					"hidden" : 0,
					"midpoints" : [ 448.5, 44.5, 464.5, 44.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-43", 0 ],
					"hidden" : 0,
					"midpoints" : [ 557.5, 39.0, 825.5, 39.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-44", 0 ],
					"hidden" : 0,
					"midpoints" : [ 557.5, 39.0, 769.5, 39.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [ 557.5, 42.0, 713.5, 42.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-43", 0 ],
					"destination" : [ "obj-39", 4 ],
					"hidden" : 0,
					"midpoints" : [ 825.5, 81.0, 786.0, 81.0, 786.0, 81.0, 775.5, 81.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-44", 0 ],
					"destination" : [ "obj-39", 3 ],
					"hidden" : 0,
					"midpoints" : [ 769.5, 78.0, 728.75, 78.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-39", 2 ],
					"hidden" : 0,
					"midpoints" : [ 713.5, 77.0, 682.0, 77.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-39", 0 ],
					"destination" : [ "obj-2", 1 ],
					"hidden" : 0,
					"midpoints" : [ 588.5, 102.0, 588.5, 102.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-45", 0 ],
					"destination" : [ "obj-39", 1 ],
					"hidden" : 0,
					"midpoints" : [ 654.5, 76.0, 635.25, 76.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-37", 0 ],
					"destination" : [ "obj-39", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-43", 0 ],
					"hidden" : 0,
					"midpoints" : [ 882.5, 45.0, 825.5, 45.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-44", 0 ],
					"hidden" : 0,
					"midpoints" : [ 882.5, 49.0, 769.5, 49.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [ 882.5, 45.0, 713.5, 45.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-37", 0 ],
					"hidden" : 0,
					"midpoints" : [ 557.5, 48.0, 588.5, 48.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-45", 0 ],
					"hidden" : 0,
					"midpoints" : [ 557.5, 45.0, 654.5, 45.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-45", 0 ],
					"hidden" : 0,
					"midpoints" : [ 882.5, 39.0, 654.5, 39.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-52", 0 ],
					"destination" : [ "obj-54", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-52", 0 ],
					"destination" : [ "obj-85", 0 ],
					"hidden" : 1,
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
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-27", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-85", 1 ],
					"destination" : [ "obj-87", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-54", 0 ],
					"destination" : [ "obj-85", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-51", 0 ],
					"destination" : [ "obj-53", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-54", 0 ],
					"destination" : [ "obj-51", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-29", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 1 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-73", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-29", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-73", 0 ],
					"destination" : [ "obj-71", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-54", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 882.5, 75.0, 882.0, 75.0, 882.0, 89.0, 809.5, 89.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-41", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-38", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [ 448.5, 44.5, 368.5, 44.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [ 450.5, 105.5, 462.5, 105.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-16", 0 ],
					"hidden" : 0,
					"midpoints" : [ 450.5, 105.5, 476.5, 105.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [ 450.5, 100.5, 374.5, 100.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-23", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [ 589.5, 306.5, 448.5, 306.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [ 374.5, 309.5, 448.5, 309.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [ 476.5, 208.5, 448.5, 208.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-38", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [ 557.5, 312.5, 448.5, 312.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-49", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-41", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [ 809.5, 308.0, 448.5, 308.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [ 935.5, 310.0, 448.5, 310.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-49", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [ 448.5, 534.0, 468.5, 534.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [ 464.5, 151.0, 448.5, 151.0 ]
				}

			}
 ]
	}

}
