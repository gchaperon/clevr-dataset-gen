if [[ $1 == "train" ]]; then
	total=70000
elif [[ $1 == "val" ]]; then
	total=15000
else
	echo bad argument $1
	exit 1
fi
step=$(((total + 6 - 1)/6))
for ((i=0; i<total; i+=step)); do
	python generate_questions.py \
		--input-scene-file ~/data/clevr/CLEVR_v1.0/scenes/CLEVR_$1_scenes.json \
		--template-dir comparison_templates/ \
		--templates-per-image 5 \
		--instances-per-template 1 \
		--scene-start-idx $i \
		--num-scenes $step \
		--output-questions-file ../output/comparison_$1_questions_$i.json \
		&
done
