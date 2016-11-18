@echo off
>export_all.log (
	for /r %%f in (*.blend) do (
		echo.
		echo FILE:  %%~nf
		blender "%%f" --background --python export-blb.py -- {'output':'%%~nf','export_count':'SINGLE','brick_definition':'GROUPS','brick_name_source':'FILE','brick_name_source_multi':'BOUNDS','export_objects':'SELECTION','export_objects_multi':'LAYERS','axis_blb_forward':'POSITIVE_Y','export_scale':100.0,'use_modifiers':True,'calculate_collision':True,'calculate_coverage':True,'coverage_top_calculate':True,'coverage_top_hide':True,'coverage_bottom_calculate':True,'coverage_bottom_hide':True,'coverage_north_calculate':True,'coverage_north_hide':True,'coverage_east_calculate':True,'coverage_east_hide':True,'coverage_south_calculate':True,'coverage_south_hide':True,'coverage_west_calculate':True,'coverage_west_hide':True,'auto_sort_quads':False,'use_materials':True,'use_vertex_colors':True,'use_object_colors':False,'round_normals':True,'custom_definitions':False,'deftoken_bounds':'bounds','deftoken_collision':'collision','deftoken_color':'c','deftoken_quad_sort_top':'qt','deftoken_quad_sort_bottom':'qb','deftoken_quad_sort_north':'qn','deftoken_quad_sort_east':'qe','deftoken_quad_sort_south':'qs','deftoken_quad_sort_west':'qw','deftoken_quad_sort_omni':'qo','deftoken_gridx':'gridx','deftoken_griddash':'grid-','deftoken_gridu':'gridu','deftoken_gridd':'gridd','deftoken_gridb':'gridb','deftoken_gridx_priority':0,'deftoken_griddash_priority':1,'deftoken_gridu_priority':2,'deftoken_gridd_priority':3,'deftoken_gridb_priority':4,'terse_mode':False,'write_log':True,'write_log_warnings':True,'float_precision':'0.000001'}
		echo.
	)
)
pause