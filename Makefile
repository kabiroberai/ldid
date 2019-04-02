DESTDIR ?= 
PREFIX  ?= /usr

.PHONY: all clean
LDID_OBJS = ldid.cpp.o lookup2.c.o
LDID_LIBS = -lplist -lcrypto -framework Security

all: ldid ldid2

%.c.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $^ -I.

%.cpp.o: %.cpp
	$(CXX) $(CFLAGS) $(CXXFLAGS) -std=c++11 -o $@ -c $^ -I.

ldid: $(LDID_OBJS)
	$(CXX) $(CFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@ $^ $(LDID_LIBS)

ldid2: ldid
	ln -s ldid ldid2

clean:
	rm -f $(LDID_OBJS) ldid ldid2

install: all
	mkdir -p $(DESTDIR)/$(PREFIX)/bin
	cp ldid ldid2 ldid3 $(DESTDIR)/$(PREFIX)/bin
