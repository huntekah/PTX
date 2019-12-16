robot.far: robot.grm byte.far numbers.far dict.tsv
	thraxcompiler --input_grammar=$< --output_far=$@

byte.far: byte.grm 
	thraxcompiler --input_grammar=$< --output_far=$@

numbers.far: numbers.grm byte.far
	thraxcompiler --input_grammar=$< --output_far=$@

clean:
	rm -f byte.far numbers.far
