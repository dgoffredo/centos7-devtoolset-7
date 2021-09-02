tracer: tracer.cpp $(shell find dd-opentracing-cpp/include -type f)
	$(CXX) \
	    -o $@ \
		-I ./dd-opentracing-cpp/include \
		-I ./dd-opentracing-cpp/deps/include \
		$< \
		-ldd_opentracing
