t <- structure(ISOdatetime(2021, 05, 27, 12, 0, 0), names="t")  # default time zone

# different calendar/locale - easy with stringx:

E(
    strftime(t, "%Y", locale="@calendar=hebrew"),
    c(t="5781"),
    worst=c(t="")
)

E(
    strftime(t, "%A", locale="pl-PL"),
    c(t="czwartek")
)

E(
    strftime(t, "%A", locale="de-DE"),
    c(t="Donnerstag")
)

E(t+10, 10+t)
E(as.numeric((10+t)-t), 10)
E(as.numeric((t+10)-t), 10)
E(t < t+10, c(t=TRUE))
E(t <= t+10, c(t=TRUE))
E(t == t, c(t=TRUE))
E(t != t+10, c(t=TRUE))


t <- structure(ISOdatetime(2021, 05, 27, 12, 0, 0, tz="GMT"), names="t")

E(
    strftime(t, "%H:%M:%S", tz="UTC", usetz=TRUE),
    P(c(t="12:00:00"), warning=TRUE),
    worst=P(c(t="::"), warning=TRUE)
)

E(
    strftime(t, "%H:%M:%S", tz="Europe/Berlin"),
    c(t="14:00:00"),
    worst=c(t="::")
)

f <- structure(c(x="%Y-%d%m", y="%d%m-%Y"), attrib1="val1")
x <- structure(c(a="1603-1502"), attrib2="val2")
E(
    attr(strptime(x, f, tz="UTC"), "tzone"),
    "UTC"
)

E(
    strftime(strptime(x, f, tz="UTC"), "%Y"),
    better=`attributes<-`(c("1603", "1502"), attributes(f)),
    `attributes<-`(c("1603", "1502"), list(names=names(f))),
    worst=`attributes<-`(c("", ""), attributes(f))
)

x <- structure(c(a="1603-1502", b="1602-1502"), attrib2="val2")
E(
    strftime(strptime(x, "%Y-%d%m", tz="UTC"), "%Y"),
    better=`attributes<-`(c("1603", "1602"), attributes(x)),
    `attributes<-`(c("1603", "1602"), list(names=names(x))),
    worst=`attributes<-`(c("", ""), attributes(x))
)


# Testing date conversion in different timezones
oldtz <- stringi::stri_timezone_get()

get_test_times <- function() {
    list(
        ISOdate(1970, 1, 1),  # POSIXct
        "1970-01-01",
        as.POSIXlt(ISOdate(1970, 1, 1)),
        as.POSIXxt("1970-01-01"),
        as.Date("1970-01-01"),
        as.POSIXlt(as.Date("1970-01-01")),
        ISOdatetime(1970, 1, 1, 12, 0, 0),  # POSIXct
        ISOdatetime(1970, 1, 1, 23, 59, 59),
        ISOdatetime(1970, 1, 1, 0, 0, 0),
        strptime("1970-01-01 12:00:00", "%Y-%m-%d %H:%M:%S"),  # POSIXct
        strptime("1970-01-01 23:59:59", "%Y-%m-%d %H:%M:%S"),
        strptime("1970-01-01 00:00:00", "%Y-%m-%d %H:%M:%S"),
        as.POSIXlt(strptime("1970-01-01 12:00:00", "%Y-%m-%d %H:%M:%S")),
        as.POSIXlt(strptime("1970-01-01 23:59:59", "%Y-%m-%d %H:%M:%S")),
        as.POSIXlt(strptime("1970-01-01 00:00:00", "%Y-%m-%d %H:%M:%S")),
        "1970-01-01 12:00",
        "1970-01-01 23:59:59",
        "1970-01-01 00:00"
    )
}

stringi::stri_timezone_set("Etc/GMT-14")
times <- get_test_times()
for (i in seq_along(times))
    E(strftime(times[[i]], "%Y-%m-%d"), "1970-01-01", bad="1970-01-02", bad="1969-12-31", worst="--", worst=NA_character_, .comment=paste0(i, " ", strcat(deparse(times[[i]]))))

stringi::stri_timezone_set("Etc/GMT+12")
times <- get_test_times()
for (i in seq_along(times))
    E(strftime(times[[i]], "%Y-%m-%d"), "1970-01-01", bad="1970-01-02", bad="1969-12-31", worst="--", worst=NA_character_, .comment=strcat(deparse(times[[i]])))

stringi::stri_timezone_set("UTC")
times <- get_test_times()
for (i in seq_along(times))
    E(strftime(times[[i]], "%Y-%m-%d"), "1970-01-01", bad="1970-01-02", bad="1969-12-31", worst="--", worst=NA_character_, .comment=strcat(deparse(times[[i]])))

stringi::stri_timezone_set("Australia/Melbourne")
times <- get_test_times()
for (i in seq_along(times))
    E(strftime(times[[i]], "%Y-%m-%d"), "1970-01-01", bad="1970-01-02", bad="1969-12-31", worst="--", worst=NA_character_, .comment=strcat(deparse(times[[i]])))

stringi::stri_timezone_set("Europe/Warsaw")
times <- get_test_times()
for (i in seq_along(times))
    E(strftime(times[[i]], "%Y-%m-%d"), "1970-01-01", bad="1970-01-02", bad="1969-12-31", worst="--", worst=NA_character_, .comment=strcat(deparse(times[[i]])))

stringi::stri_timezone_set("America/Montreal")
times <- get_test_times()
for (i in seq_along(times))
    E(strftime(times[[i]], "%Y-%m-%d"), "1970-01-01", bad="1970-01-02", bad="1969-12-31", worst="--", worst=NA_character_, .comment=strcat(deparse(times[[i]])))


stringi::stri_timezone_set(oldtz)
