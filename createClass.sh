#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Must pass class name"
    exit 1
fi

caps=$(echo $1 | tr '[:lower:]' '[:upper:]') 
title="${1^}"

result="#ifndef ${caps}_H
#define ${caps}_H

#include \"game_object.h\"

using namespace std;

class ${title} {

	public:
		//constructor
		${title}();

		//destructor
		~${title}();

		void print();

	private:

}}; //${caps}_H
#endif"

echo "$result" > "${title}.h"

result="#include "${title}.h"

${title}::${title}(){{


}}

${title}::${title}(${title}& ${1}){{


}}


${title}::~${title}(){{


}}

void ${title}::print(){{

}}"

echo "$result" > "${title}.cpp"

exit 0
